class CommentsController < ApplicationController
	def create
		@location = Location.find(params[:location_id])
		@comment = @location.comments.create!(params[comment_params])
		redirect_to @location
	end

	private
	def comment_params
      params.require(:comment).permit(:body)
    end
end
