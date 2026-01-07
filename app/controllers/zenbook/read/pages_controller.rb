module Zenbook
  class Read::PagesController < ::ApplicationController
    include Zenbook::ApplicationHelper
    allow_unauthenticated_access only: %i[show]
    skip_before_action :require_admin!
    
    layout 'reading'

    def show 
      @page = Page.find(params[:id])
    end
  end
end
