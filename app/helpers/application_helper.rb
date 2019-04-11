module ApplicationHelper
	def alert_for(flash_type)
  { success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
  }[flash_type.to_sym] || flash_type.to_s
	end

def form_image_select(post)
  return image_tag post.image.url(:medium),
        id: 'image-preview',
        class: 'img-responsive' if post.image.exists?
  image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
end

def profile_avatar_select(user)
  return image_tag user.avatar.url(:medium),
                   id: 'image-preview',
                   class: 'img-responsive img-circle profile-image' if user.avatar.exists?
  image_tag 'https://png.pngtree.com/svg/20161027/631929649c.svg', id: 'image-preview',
                                  class: 'img-responsive img-circle profile-image'
end
  # helper_method :current_user
  def current_user
    if session[:user_id] != nil
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
