module Zenbook
  class Read::BooksController < ::ApplicationController
    layout 'exam_prep_student'


    def index
      @books = Zenbook::Book.published.latest
    end
  end
end
