# coding : utf-8
class PlaysController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_play, only: [:show, :edit, :update, :destroy]

  # GET /plays
  # GET /plays.json
  def index
    redirect_to controller: 'compatibilities', action: 'new'
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
    @feeds = Feed.all.order('updated_at desc').limit(20)
    @time_word = Hash.new
    @feeds.each do |feed|
      @time_word[feed.id] = time_ago_in_words(feed.created_at)
    end
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1/edit
  def edit
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = Play.where(uniq_key:params[:play][:uniq_key], owner_name: params[:play][:owner_name], animal_name:params[:play][:animal_name]).first
    unless @play
      play_answer = PlayAnswer.offset( rand(PlayAnswer.count) ).first 
      answer = play_answer.answer.gsub(/%%|&&/, "%%" => params[:play][:owner_name], "&&" => params[:play][:animal_name])
      @play = Play.new(play_params.merge(play_answer_id: 1, answer: answer))
    end
    respond_to do |format|
      if @play.save
        format.html { redirect_to @play, notice: 'Play was successfully created.' }
        format.json { render :show, status: :created, location: @play }
      else
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'Play was successfully updated.' }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params[:play].permit(:uniq_key ,:play_answer_id, :owner_name, :animal_name, :answer)
    end
end
