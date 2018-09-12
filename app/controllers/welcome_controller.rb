class WelcomeController < ApplicationController
  def index
    @presenter = WordPresenter.new(params[:q]) if params[:q]
  end
end
