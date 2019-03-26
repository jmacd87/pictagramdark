class CommentsController < ApplicationController
	before_action :set_post, :check_user
  
  def index
    @comments = @post.comments.order("created_at ASC")

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  def show
  end

  def edit
  end

  def update
  end

def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
      create_notification(@post, @comment)
    else
      flash[:alert] = "Check the comment form, something went wrong."
      redirect_to(:back)
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
    end
  end

private

def create_notification(post, comment)
  return if post.user.id == current_user.id 
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: comment.id,
                        notice_type: 'comment')
end

def comment_params
  params.require(:comment).permit(:content)
end

def set_post
  @post = Post.find(params[:post_id])
end

def check_user
      if current_user == nil
      
      redirect_to :back
      flash[:alert] = "You must be signed in to do that"
    end
  end
end
