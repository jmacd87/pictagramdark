class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
before_action :check_user
	def index
    @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
     respond_to do |format|
      format.js
      format.html
    end
  end

	def show
	end

 def new
    @post = current_user.posts.build
  end

  def browse
    @posts = Post.all.order('created_at DESC').page params[:page]
   respond_to do |format|
      format.js
      format.html
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

	def edit
	end

	def update
 	if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render :edit
    end
	end


	def destroy
	  @post.destroy
	  redirect_to posts_path
	end

def like
  if @post.liked_by current_user
    create_notification @post
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
end

def unlike
  if @post.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
end

private

def create_notification(post)
    return if post.user == current_user
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: post.id,
                        notice_type: 'like')
end

def post_params
  params.require(:post).permit(:image, :caption)
end

def set_post
  @post = Post.find(params[:id])
end

def check_user
      if current_user == nil
      
      redirect_to login_path
      flash[:alert] = "You must be signed in to do that"
    end
  end

end
