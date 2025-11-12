module Zenbook
  class Read::PagesController < ::ApplicationController
    layout 'reading'

    def show 
      @page = Page.find(params[:id])
    end
  end
end
