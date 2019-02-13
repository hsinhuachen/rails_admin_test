class ProjectController < ApplicationController
  def index
  	@posts = Project.all
  end

 #  private
 #  	def post_params
 #  		params.require(:project).permit(:title,:desc,:tag_list)
 #  	end
end
