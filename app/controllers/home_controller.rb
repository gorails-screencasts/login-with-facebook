class HomeController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @graph = current_user.services.facebook.last.client
    page_params = params.permit!.to_h[:page]
    @results = params[:page] ? @graph.get_page(page_params) : @graph.get_connections("me", "feed")
  end

  def terms
  end

  def privacy
  end
end
