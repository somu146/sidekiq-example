class TeamsController < ApplicationController

	def index
    teams = Team.all.select(:id, :name, :rating)
    HelloWorldJob.perform_later
    render json: {data: teams}
	end

	private
	  def team_params
	  	params.permit(:id)
	  end
end
