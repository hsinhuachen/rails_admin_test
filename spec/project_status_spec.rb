require "./project_status"
  
RSpec.describe ProjectStatus do
	describe "發佈功能" do
	  it "發佈專案" do
	  	project = ProjectStatus.new(0)
        project.action 1
        expect(project.status).to be 1
	  end
	  it "取消發佈" do
	  	project = ProjectStatus.new(1)
        project.action 0
        expect(project.status).to be 0
	  end
	end
end