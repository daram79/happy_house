class UserCoversController < ApplicationController
  before_action :set_user_cover, only: [:show, :edit, :update, :destroy]

  # GET /user_covers
  # GET /user_covers.json
  def index
    @user_covers = UserCover.all
  end

  # GET /user_covers/1
  # GET /user_covers/1.json
  def show
  end

  # GET /user_covers/new
  def new
    @user_cover = UserCover.new
  end

  # GET /user_covers/1/edit
  def edit
  end

  # POST /user_covers
  # POST /user_covers.json
  def create
    @user_cover = UserCover.new(user_cover_params)
    user_cover = UserCover.find_by_user_id(params[:user_cover][:user_id])
    if user_cover
      @user_cover = UserCover.new(user_cover_params.merge(name: user_cover.name))
      user_cover.destroy
    end

    respond_to do |format|
      if @user_cover.save
        format.html { redirect_to @user_cover, notice: 'User cover was successfully created.' }
        format.json { render :show, status: :created, location: @user_cover }
      else
        format.html { render :new }
        format.json { render json: @user_cover.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_name
    user_cover = UserCover.find_by_user_id(params[:user_cover][:user_id])
    if user_cover
      user_cover.update(name: params[:user_cover][:name])
    else
      UserCover.create(user_id: params[:user_cover][:user_id], name: params[:user_cover][:name])
    end
    render json: {status: 200}
    
  end
  
  def get_image_url
    user = User.find(params[:user_id])
    
    if user.user_cover && user.user_cover.image
      img_url = user.user_cover.image.url
    end
    
    img_url = "/uploads/cover/cover.png" unless img_url
    
    render json: {status: 200, cover_image_url: img_url, 
      total_visit_count: user.total_visit_count, today_visit_count: user.today_visit_count}
  end

  # PATCH/PUT /user_covers/1
  # PATCH/PUT /user_covers/1.json
  def update
    respond_to do |format|
      if @user_cover.update(user_cover_params)
        format.html { redirect_to @user_cover, notice: 'User cover was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_cover }
      else
        format.html { render :edit }
        format.json { render json: @user_cover.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_covers/1
  # DELETE /user_covers/1.json
  def destroy
    @user_cover.destroy
    respond_to do |format|
      format.html { redirect_to user_covers_url, notice: 'User cover was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def check_cover_name
    user_cover = User.find(params[:id]).user_cover
    if user_cover && user_cover.name
      render json:{user_name_flg: true}
    else
      render json:{user_name_flg: false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_cover
      @user_cover = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_cover_params
      params[:user_cover].permit(:user_id, :name, :ip, :image)
    end
end
