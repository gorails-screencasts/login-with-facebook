class HomeController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    facebook = current_user.services.facebook.last
    if facebook.present?
      @graph = facebook.client
      page_params = params.permit!.to_h[:page]
      @results = params[:page] ? @graph.get_page(page_params) : @graph.get_connections("me", "feed")
    else
      @results = []
    end
  end

  def terms
  end

  def privacy
  end
end
