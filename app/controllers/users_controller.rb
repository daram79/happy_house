class UsersController < ApplicationController
  include ActionView::Helpers::DateHelper
  
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_user_data]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user = User.find_by_email(params[:user][:email])
    unless user
      @user = User.new(user_params)
      if @user.save
        render json: {id: @user.id}
      else
        render json: {id: nil}
      end
    else
      render json: {id: user.id}
    end
    

    # respond_to do |format|
      # if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
      # else
        # format.html { render :new }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def set_registration_id
    # @user = User.find(params[:id])
    # @user.update(registration_id: params[:registration_id])
    user_id = params[:id]
    regi_id = params[:registration_id]
    registrations = Registration.where(user_id: params[:id], registration_id: params[:registration_id])
    if user_id != "" && regi_id != "" && registrations.blank?
        Registration.create(user_id: params[:id], registration_id: params[:registration_id])
    end
    render :json => {status: 200}
  end
  
  def get_alram_on
    user = User.find(params[:id])
    render :json => {status: 200, alram_on: user.alram_on}
  end
  
  def get_user_data
    render :json => {status: 200, alram_on: @user.alram_on, user_cover: @user.user_cover, 
      total_visit_count: @user.total_visit_count, today_visit_count: @user.today_visit_count, close_guide: @user.close_guide }
  end
  
  def close_guide
    user = User.find(params[:id])
    user.update(close_guide: true)
    render :json => {status: 200}
  end
  
  def createVisitCount
    user_id = params[:user_id]
    visit_user_id = params[:visit_user_id]
    if UserVisitCount.chk_visit_data(user_id, visit_user_id)
      UserVisitCount.create(user_id: user_id, visit_user_id: visit_user_id)
    end
    render :json => {status: 200}
  end
  
  def get_visitor_book
    @visitor_books = VisitorBook.where(user_id: params[:id]).order('id desc').limit(100)
    @time_word = Hash.new
    @visitor_books.each do |visitor_book|
      @time_word[visitor_book.id] = time_ago_in_words(visitor_book.created_at)
    end
  end
  
  def create_visitor_book
    VisitorBook.create(user_id: params[:user_id], send_user_id: params[:send_user_id], content: params[:content])
    render :json => {status: 200}
  end
  
  def agreement
    
  end
  
  def personal_information_policy
    
  end
  
  def notice
    @notices = Notice.all.order("id desc")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:email)
    end
end
