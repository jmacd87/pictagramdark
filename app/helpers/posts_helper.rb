module PostsHelper

  
  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def liked_post(post)
    if current_user.voted_for? post
      return link_to '', unlike_post_path(post), remote: true, id: "like_#{post.id}", 
          class: "glyphicon glyphicon-heart"
    else
      link_to '', like_post_path(post), remote: true, id: "like_#{post.id}", 
          class: "glyphicon glyphicon-heart-empty" 
    end
  end

  def count_comments(post)
    counter = post.comments.count
    "#{counter} Comments" if counter == 1
    "#{counter} Comment"
  end

  private

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end