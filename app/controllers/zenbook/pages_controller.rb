module Zenbook
  class PagesController < ::ApplicationController
    layout 'creator'
    before_action :set_book, only: [:create]
    before_action :set_page, only: [:show, :edit, :update, :publish]
    # layout 'zenbook/reading_layout', except: [:new, :create]

    def show
    end

    # def new
    #   @page = @book.pages.new
    # end

    def edit
    end

    def create
      @page = @book.pages.new(title: "Unititled Page")
      if @page.save
        redirect_to edit_page_path(@page)
      end
    end

    def update 
      
    end

    def publish
      @page = @book.pages.find(params[:id])
      @page.published!
      redirect_to [@book, @page]
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_page 
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :content)
    end
  end
end
