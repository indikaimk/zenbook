module Zenbook
  class BookSubscription < ApplicationRecord
    belongs_to :user
    belongs_to :book
  end
end
