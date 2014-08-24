class CommentsController < ApplicationController
    before_filter :require_login, except: [:index, :vote]
    before_action :set_location, except: [:vote]
    skip_before_filter :verify_authenticity_token  
    respond_to :html, :js
    
    def index
        @comment = Comment.by_votes
    end

    def new
        @comment = Comment.new
    end

	def create
		@comment = @location.comments.build(comment_params)
        @comment.user = current_user
        @comment.save
	end

    def vote
    	vote = current_user.comment_votes.new(value: params[:value], comment_id: params[:id])
    	vote.save
    end

    private

    def set_location
      @location = Location.find(params[:location_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :location_id, :user_id, :id, :ratio, :hot)
    end
end
