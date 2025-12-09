module Zenbook
  class Read::BooksController < ::ApplicationController
    allow_unauthenticated_access only: %i[index latest_book]

    # layout 'exam_prep_student', only: [:index]
    before_action :set_book, only: [:show_toc, :hide_toc]

    def index
      @books = Zenbook::Book.published.latest
    end

    def latest_book
      @latest_book = Zenbook::Book.published.latest.first
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
