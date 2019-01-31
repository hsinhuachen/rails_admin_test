class ProjectController < ApplicationController
  def index
  	@posts = Project.all
  end

 #  def new
 #  	project.title = post_params[:title]
	# project.desc = post_params[:desc]
	# project.tag_list = post_params[:tag_list]
 #  end

 #  def update
 #  	project.title = post_params[:title]
	# project.desc = post_params[:desc]
	# project.tag_list = post_params[:tag_list]
 #  end

 #  private
 #  	def post_params
 #  		params.require(:project).permit(:title,:desc,:tag_list)
 #  	end
end
