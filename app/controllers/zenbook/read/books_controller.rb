module Zenbook
  class Read::BooksController < ::ApplicationController
    layout 'exam_prep_student'
    before_action :set_book, only: [:show_toc, :hide_toc]

    def index
      @books = Zenbook::Book.published.latest
    end

    def show_toc 
    end

    def hide_toc
    end

    private
      def set_book 
        @book = Book.find(params[:id])      
      end
  end
end
