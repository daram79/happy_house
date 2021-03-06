# coding : utf-8

class FeedsController < ApplicationController
  include ActionView::Helpers::DateHelper
  
  before_action :set_feed, only: [:edit, :update, :destroy, :comment]

  # GET /feeds
  # GET /feeds.json
  def index
    if params[:user_id]
      @current_user = User.find(params[:user_id])
      if "newest".eql?(params[:tab])
        @feeds = Feed.all.order('updated_at desc').limit(500)
      else
        user_ids = UserLike.where(user_id: params[:user_id]).pluck(:like_user_id)
        @feeds = Feed.where(user_id: user_ids).order('updated_at desc').limit(500)
        # @feeds = Feed.all.order('updated_at desc').limit(50)
      end
      
    else
      @feeds = Feed.all.order('updated_at desc').limit(50)
    end
    
    
    @time_word = Hash.new
    @feeds.each do |feed|
      @time_word[feed.id] = time_ago_in_words(feed.created_at)
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    if params[:user_id]
      @current_user = User.find(params[:user_id])
    end
    
    # @item_photo = @feed.feed_photos[0]
    @feed = Feed.where("id = ?", params[:id]).first
    @item_photo = @feed.feed_photos[0] if @feed
    @time_word = time_ago_in_words(@feed.created_at)
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    content_type = params[:feed][:feed_photos_attributes]["0"][:image].content_type
    # unless "image".eql?(content_type.split('/')[0])
      # flash[:notice] = "지원하지 않는 형식의 사진입니다."
      # redirect_to action: "new"
    # else
      content = params[:feed][:content]
      tags = Feed.get_tag(content) #태그 작성후 DB에 넣고 태그값 리턴해줌
      html_content = Feed.make_html(content, tags)
      #@feed = Feed.new(feed_params)
      @feed = Feed.new(feed_params.merge(html_content: html_content))
      respond_to do |format|
        if @feed.save
          #format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
          Feed.create_tag(@feed.id, tags)
          format.html { redirect_to feeds_url, notice: 'Feed was successfully created.' }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    # end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def destroy_feeds
    feed_ids = params[:feed_id].split(",")
    Feed.destroy(feed_ids)
    # hashData = params[:feed_id]
    # feed_ids = []
    # hashData.each do |k, v|
      # feed_ids.push v
    # end
    # debugger
#       
    # @feeds = Feed.find(feed_ids)
    render json: {status: 200}
  end
  
  def add_like
    current_user = User.find(params[:user_id])
    like = Like.where(feed_id: params[:id], user_id: current_user.id).first
    unless like
      like_flg = true
      like = Like.create(feed_id:params[:id] , user_id: current_user.id, like_type: "feed")
    else
      like.destroy
      like_flg = false
    end
    like_count = Like.where(feed_id:params[:id]).count
    like.feed.update(like_count: like_count)
    render json: {like_flg: like_flg}
  end
  
  def search_tag
    tag = params[:tag]
    feed_ids = FeedTag.where("tag_name = ?",tag).pluck(:feed_id)
    @feeds = Feed.where(id: feed_ids)
  end
  
  def comment
    @comments = @feed.comments
    @time_word = Hash.new
    @comments.each do |comment|
      @time_word[comment.id] = time_ago_in_words(comment.created_at)
    end
  end
  
  def add_comment
    current_user = User.find(params[:user_id])
    
    feed = Feed.find(params[:id])
    comment = Comment.create(feed_id:params[:id] , user_id: current_user.id, content: params[:comment_content], ip: params[:ip])
    comment_count = Comment.where(feed_id:params[:id]).count
    comment.feed.update(comment_count: comment_count)
    
    render json: {comment_content: comment.content}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params[:feed].permit(:user_id, :content, :html_content, :ip, feed_photos_attributes: [:image])
    end
end
