class WelcomeController < ApplicationController
  def index
  	@posts = Project.all
  end
end
