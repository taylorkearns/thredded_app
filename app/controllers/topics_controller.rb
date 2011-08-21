class TopicsController < ApplicationController
  layout 'application'
  before_filter :pad_params,  :only => [:create, :update]
  before_filter :pad_post,    :only => :create
  before_filter :pad_topic,   :only => :create
  helper_method :site, :messageboard, :topic

  def index
    authorize! :index, messageboard, :message => "You are not authorized access to this messageboard."
    # flash[:error] = "You are not authorized to access this page." and redirect_to root_path unless can? :read, messageboard
    @topics = messageboard.topics #.latest.page params[:page]
  end

  def show
    authorize! :show, topic
    @post = Post.new
  end

  def new
    @topic = messageboard.topics.build
    @topic.posts.build.images.build

  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.posts.create(params[:topic][:posts_attributes]["0"])
    @topic.messageboard = messageboard
    @topic.users << current_user if @topic.users.size > 0 && !@topic.users.include?(current_user) 
    @topic.save!
    redirect_to messageboard_topics_path(messageboard)
  end

  def edit
    authorize! :update, topic
  end
 
  def update
    topic.update_attributes(params[:topic])
    redirect_to messageboard_topic_path(messageboard, topic)
  end

  # ======================================
 
  def messageboard
    @messageboard ||= Messageboard.where(:name => params[:messageboard_id]).first
  end

  def topic
    @topic ||= Topic.find_by_slug(params[:id])
  end

  def site 
    @site ||= Site.find_by_slug(params[:site_id])
  end

  def current_user_name 
    @current_user_name ||= current_user.nil? ? "anonymous" : current_user.name
  end

  # ======================================

  private
  
    def pad_params
      params[:topic][:user] = current_user_name
      params[:topic][:last_user] = current_user_name
    end

    def pad_topic
      params[:topic][:last_user] = current_user_name
      params[:topic][:post_count] = 1
    end

    def pad_post
      params[:topic][:posts_attributes]["0"][:ip] = request.remote_ip
      params[:topic][:posts_attributes]["0"][:user] = current_user_name
    end

end
