class CommentsController < ApplicationController
  def create
    @posting = Posting.find(params[:posting_id])
    @comment = @posting.comments.create(comment_params)
    redirect_to posting_path(@posting)
  end

  def destroy
    @posting = Posting.find(params[:posting_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to posting_path(@posting)
  end

  def comment_params
    params.require(:comment).permit(:commenter, :posting, :body, :posting_id)
  end
end
