module Zenbook
  class BooksController < ::ApplicationController
    before_action :set_book, only: [:show, :edit, :update]
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
        render :new
      end
    end

    def update
      if @book.update(book_params)
        redirect_to @book
      else
        render :edit
      end
    end

    private

    def book_params
      params.require(:book).permit(:title, :description, :state, :cover_image)
    end

    def set_book 
      @book = Book.find(params[:id])      
    end
  end
end
