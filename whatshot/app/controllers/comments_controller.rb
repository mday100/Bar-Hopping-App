class CommentsController < ApplicationController
	def create
		@location = Location.find(params[:location_id])
		@comment = @location.comments.create(comment_params)
		redirect_to @location
	end

    def index
    	@comment = Comment.by_votes
    end

    def vote
    	vote = current_user.comment_votes.new(value: params[:value], comment_id: params[:id])
    	if vote.save
    		redirect_to :back, notice: "Thank you for voting!"
    	else
    		redirect_to :back, alert: "Unable to vote, perhaps you already did?"
    	end
    end

    private
    def comment_params
      params.require(:comment).permit(:body, :location_id, :user_id)
    end
end
