module Zenbook
  class Read::PagesController < ::ApplicationController
    layout 'zenbook/reading_layout'

    def show 
      @page = Page.find(params[:id])
    end
  end
end
