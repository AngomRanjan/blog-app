class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    @post = Post.find(params[:post_id] || params[:id])
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post = @post

    respond_to do |format|
      if @comment.save!
        format.html do
          redirect_to user_post_url(current_user, @post), notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @post.comments_counter -= 1
    @comment.destroy
    redirect_to user_post_url(@post.author, @post), notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
