module Zenbook
  class Book < ApplicationRecord
    has_many :pages
    enum :state, draft: 0, in_progress: 1, completed: 2 #The latest in_progress book to be highlighted in the navigation menu
    
  end
end
