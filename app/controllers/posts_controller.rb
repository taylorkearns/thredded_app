class PostsController < ApplicationController
  include TopicsHelper 
  load_and_authorize_resource :only => [:index, :show]
  layout 'application'
  before_filter :pad_post, :only => :create
  helper_method :messageboard, :topic

  def create
    p = topic.posts.create(params[:post])
    redirect_to messageboards_path
  end

  def edit
    authorize! :update, post
  end

  def update
    post.update_attributes(params[:post])
    redirect_to link_for_posts(site, messageboard, topic)
  end

  # ======================================
 
  def post
    @post ||= topic.posts.find(params[:id]) 
  end

  def current_user_name 
    @current_user_name ||= current_user.nil? ? "anonymous" : current_user.name
  end

  # ======================================

  private

    def pad_post
      params[:post][:ip] = request.remote_ip
      params[:post][:user] = current_user
      params[:post][:messageboard] = messageboard
    end

end
