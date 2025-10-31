module Zenbook
  class Bookmark < ApplicationRecord
    belongs_to :user
    belongs_to :page
  end
end
