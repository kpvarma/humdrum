class WelcomeController < ApplicationController
  
  before_filter :set_navs
  
  # GET /
  def index
  end
  
  private
  
  def set_navs
    set_nav("Home")
  end
  
end
