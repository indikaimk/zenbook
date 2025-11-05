module Zenbook
  class Book < ApplicationRecord
    has_many :pages
    enum :state, draft: 0, in_progress: 1, completed: 2 #The latest in_progress book to be highlighted in the navigation menu
    
    scope :published, -> { where.not(state: :draft) }
    scope :in_progress, -> { where(state: :in_progress) }
    scope :latest, -> { order(updated_at: :desc).limit(5) }

    has_one_attached :cover_image
  end
end
