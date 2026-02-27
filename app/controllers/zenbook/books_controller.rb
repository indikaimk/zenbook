module Zenbook
  class BooksController < ::ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :publish]
    layout 'creator'

    def index
      @books = Book.all
    end

    def show
    end

    def edit
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to @book
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        redirect_to @book
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def publish
      
      # Optional: You might want to update a status flag here
      # @book.update!(status: 'publishing')

      # Send the heavy lifting to the background queue
      GenerateBookPdfJob.perform_later(@book.id)

      flash[:notice] = "Publishing initiated! The PDF is being compiled by the rendering engine. This usually takes about 30 seconds."
      
      # Redirect back to the book's show page or admin dashboard
      redirect_to @book
    end

    def preview_pdf
      @book = Book.find(params[:id])
      render :pdf_template, layout: 'ebook_pdf_layout'
    end

    private

    def book_params
      params.require(:book).permit(:title, :description, :state, :cover_image, :is_markdown)
    end

    def set_book 
      @book = Book.find_by(slug: params[:id])      
    end
  end
end
