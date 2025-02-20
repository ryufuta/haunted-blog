# frozen_string_literal: true

class Api::LikingUsersController < ApplicationController
  def index
    blog = Blog.find(params[:blog_id])
    @users = remove_email(blog.liking_users.order(:id))
    my_liking = blog.likings.find_by(user: current_user)
    @destroy_path = my_liking ? api_blog_liking_path(blog, my_liking, format: :json) : nil
  end

  private

  def remove_email(users)
    users.map do |user|
      user.email = nil
      user
    end
  end
end
