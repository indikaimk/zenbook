module Zenbook
  class Book < ApplicationRecord
    has_many :pages
    enum :state, draft: 0, in_progress: 1, completed: 2 #The latest in_progress book to be highlighted in the navigation menu
    
    scope :published, -> { where.not(state: :draft) }
    scope :in_progress, -> { where(state: :in_progress) }
    scope :latest, -> { order(updated_at: :desc).limit(5) }

    before_validation :generate_slug

    validate :must_have_pages_to_be_active
    validate :prohibit_is_markdown_change, on: :update
    validates :slug, presence: true, uniqueness: true
    

    has_one_attached :cover_image
    has_one_attached :pdf_book

    def toc_and_final_content
      # 1. Grab the raw HTML from the method we wrote previously
      raw_html = render_content
      
      # 2. Parse the HTML tree using Nokogiri
      doc = Nokogiri::HTML::DocumentFragment.parse(raw_html)
      
      # 3. Setup the ToC wrapper
      toc_html = String.new
      toc_html << "<div class='table-of-contents page-break-after'>\n"
      toc_html << "<h1 class='text-4xl font-bold mb-8 border-b pb-4'>Table of Contents</h1>\n"
      toc_html << "<ul class='space-y-2'>\n"

      # 4. Sweep the document for all headings
      doc.css('h1, h2, h3').each do |heading|
        # Skip the Table of Contents title itself if it accidentally gets caught
        next if heading.text.strip.downcase == 'table of contents'

        # Redcarpet adds IDs, but RichText doesn't. Generate a URL-safe slug if missing.
        slug = heading['id'] || heading.text.parameterize
        
        # Force the ID back into the actual HTML document so the links have a target
        heading['id'] = slug 

        # Determine the heading level to calculate indentation
        level = heading.name.gsub('h', '').to_i # Converts 'h2' to 2
        
        # Map the heading level to Tailwind indentation classes
        indent_class = case level
                      when 1 then "ml-0 font-bold mt-6 text-lg"
                      when 2 then "ml-6 text-gray-800"
                      when 3 then "ml-12 text-sm text-gray-600 italic"
                      else "ml-12"
                      end

        # Add the linked list item to the ToC
        toc_html << "<li class='#{indent_class}'>"
        toc_html << "<a href='##{slug}' class='hover:text-primary transition-colors'>#{heading.text}</a>"
        toc_html << "</li>\n"
      end

      toc_html << "</ul>\n</div>"

      # Return the ToC HTML and the Modified Document HTML (now guaranteed to have IDs)
      [toc_html, doc.to_html]
    end

    # 1. The Main Aggregator Method
    def render_content
      # Ensure pages are ordered correctly (assuming you have a position or chapter_number column)
      ordered_pages = pages.published.order(:page_number) 

      ordered_pages.map do |chapter|
        # Extract the text (ActionText uses .body or .to_s, text columns use just the attribute name)
        # Adjust 'content' to whatever your Chapter attribute is actually named
        raw_text = chapter.content.to_s 
        
        chapter_html = if is_markdown
                        render_markdown(raw_text)
                      else
                        # ActionText is already safely converted to HTML behind the scenes
                        raw_text 
                      end

        # Wrap each chapter in a semantic HTML section. 
        # The 'chapter-section' class is crucial for our CSS page-break rules!
        "<div class='chapter-section'>#{chapter_html}</div>"
      end.join("\n\n")
    end

    def to_param
      slug
    end

    private

    # 2. The Technical Markdown Parser
    def render_markdown(text)
      return "" if text.blank?

      # We use specific HTML renderer settings for technical writing
      renderer = Redcarpet::Render::HTML.new(
        hard_wrap: true,
        with_toc_data: true, # Automatically adds id="header-name" to H1/H2 tags for deep linking
        safe_links_only: true
      )

      # These extensions are mandatory for cloud/devops ebooks
      extensions = {
        fenced_code_blocks: true, # Allows ```ruby or ```bash
        tables: true,             # Crucial for parameter/argument reference tables
        autolink: true,
        strikethrough: true,
        no_intra_emphasis: true   # Prevents 'my_variable_name' from italicizing the word 'variable'
      }

      Redcarpet::Markdown.new(renderer, extensions).render(text)
    end

    def generate_slug
      # Only generate a new slug if the title actually exists
      return if title.blank?

      # We update the slug if it's currently empty, OR if you just renamed the book
      if slug.blank? || title_changed?
        # .parameterize turns "AWS SysOps Guide!" into "aws-sysops-guide"
        self.slug = title.parameterize
      end
    end

    def prohibit_is_markdown_change
      if is_markdown_changed?
        errors.add(:is_markdown, "cannot be changed after the book is created")
      end
    end

    def must_have_pages_to_be_active
      if (in_progress? || completed?) && pages.empty?
        errors.add(:state, "cannot be #{state} without any pages")
      end
    end
  end
end
