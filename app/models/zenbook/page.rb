module Zenbook
  class Page < ApplicationRecord
    belongs_to :book
    has_rich_text :content
    enum :state, draft: 0, published: 1

    before_save :set_page_number, if: :new_record?
    after_save :update_book_state, if: :saved_change_to_state?

    scope :published, -> { where(state: :published) }
    scope :sorted, -> { order(page_number: :asc) }

    private

    def set_page_number
      self.page_number = book.pages.count + 1
    end

    def update_book_state
      if published? && book.in_progress?
        # Book is already in progress, do nothing
      elsif published?
        book.in_progress!
      end
    end
  end
end
