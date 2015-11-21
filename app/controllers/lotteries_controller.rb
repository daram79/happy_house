class LotteriesController < ApplicationController
  before_action :set_lottery, only: [:show, :edit, :update, :destroy]

  # GET /lotteries
  # GET /lotteries.json
  def index
    @lotteries = Lottery.all
  end

  # GET /lotteries/1
  # GET /lotteries/1.json
  def show
  end

  # GET /lotteries/new
  def new
    @lottery = Lottery.new
  end

  # GET /lotteries/1/edit
  def edit
  end

  # POST /lotteries
  # POST /lotteries.json
  def create
    @lottery = Lottery.new(lottery_params)

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to @lottery, notice: 'Lottery was successfully created.' }
        format.json { render :show, status: :created, location: @lottery }
      else
        format.html { render :new }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lotteries/1
  # PATCH/PUT /lotteries/1.json
  def update
    respond_to do |format|
      if @lottery.update(lottery_params)
        format.html { redirect_to @lottery, notice: 'Lottery was successfully updated.' }
        format.json { render :show, status: :ok, location: @lottery }
      else
        format.html { render :edit }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lotteries/1
  # DELETE /lotteries/1.json
  def destroy
    @lottery.destroy
    respond_to do |format|
      format.html { redirect_to lotteries_url, notice: 'Lottery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def create_lottery
    
    today = Time.now.to_s[0..9]
    tel_no = params[:tel_no]
    type = params[:type]
    s_log = type == "web" ? LOG_STAR_BUCKS_EVENT_WEB : LOG_STAR_BUCKS_EVENT_APP
    device = type == "app" ? "android" : session[:user_agent]
    
    Log.create_log(cookies[:uniq_key], LOG_STAR_BUCKS, s_log, device, params[:user_id])
    
    if type == "app"
      lottery = Lottery.where(user_id: params[:user_id], lottery_type: type, date: today)
      if lottery.blank?
        lottery = Lottery.create_lottery(tel_no, type, today, params[:user_id], 1)
        render json: {lottery_flg: 0, lottery: lottery}
      elsif lottery.size == 1
        #1번 참여
        feed = Feed.where(user_id: params[:user_id])
        if feed.size > 0
          #이벤트에 한번 참여하고, 피드에 글 있을때
          lottery = Lottery.create_lottery(tel_no, type, today, params[:user_id], 2)
          render json: {lottery_flg: 1, feed_data:true, lottery: lottery}
        else
          #이벤트에 한번 참여하고, 피드에 글 없을때
          render json: {lottery_flg: 1, feed_data:false, lottery: lottery[0]}
        end
      else
        #2번이상 이벤트 참여
        render json: {lottery_flg: -1, lottery: lottery[0]}
      end
    else
      #app이 아닌 다른곳에서 들어왔을때
      render json: {lottery_flg: -4}
    end
  end
  
  def update_lottery_tel_no
    Log.create_log(cookies[:uniq_key], LOG_STAR_BUCKS, LOG_STAR_BUCKS_UPDATE_TEL_NO, "android", params[:user_id])
    lottery = Lottery.find(params[:lottery_id])
    lottery.update(tel_no: params[:tel_no])
    render json: {status: :ok}
  end
  
  def check_event
    lottery = Lottery.last
    if lottery != nil
      if lottery.id < 2000
        render json:{ event: true }
      else
        render json:{ event: false }
      end
    else
      render json:{ event: true }
    end
  end
  
  def get_lottery_data
    lotteries = Lottery.where(user_id: params[:user_id]).order(:id)
    render json: lotteries
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params[:lottery]
    end
end
