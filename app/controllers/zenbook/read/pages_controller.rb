module Zenbook
  class Read::PagesController < ::ApplicationController
    allow_unauthenticated_access only: %i[show]
    layout 'reading'

    def show 
      @page = Page.find(params[:id])
    end
  end
end
