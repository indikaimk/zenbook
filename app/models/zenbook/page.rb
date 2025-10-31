module Zenbook
  class Page < ApplicationRecord
    belongs_to :book
    has_rich_text :content
    enum :state, draft: 0, published: 1

    after_save :update_book_state, if: :saved_change_to_state?

    private

    def update_book_state
      if published? && book.in_progress?
        # Book is already in progress, do nothing
      elsif published?
        book.in_progress!
      end
    end
  end
end
