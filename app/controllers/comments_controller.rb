class CommentsController < ApplicationController
  def new
  end

  def create
    comment = Comment.create(comment_params)
    render json: {
      comment: comment.comment,
      first_name: comment.user.first_name,
      last_name: comment.user.last_name
    }
  end

  private 

  def comment_params
    params.require(:comment).permit(:comment, :food_id, :user_id)
  end
end
