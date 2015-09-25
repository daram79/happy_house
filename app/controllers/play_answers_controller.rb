class PlayAnswersController < ApplicationController
  before_action :set_play_answer, only: [:show, :edit, :update, :destroy]

  # GET /play_answers
  # GET /play_answers.json
  def index
    @play_answers = PlayAnswer.all
  end

  # GET /play_answers/1
  # GET /play_answers/1.json
  def show
  end

  # GET /play_answers/new
  def new
    @play_answer = PlayAnswer.new
  end

  # GET /play_answers/1/edit
  def edit
  end

  # POST /play_answers
  # POST /play_answers.json
  def create
    @play_answer = PlayAnswer.new(play_answer_params)

    respond_to do |format|
      if @play_answer.save
        format.html { redirect_to @play_answer, notice: 'Play answer was successfully created.' }
        format.json { render :show, status: :created, location: @play_answer }
      else
        format.html { render :new }
        format.json { render json: @play_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /play_answers/1
  # PATCH/PUT /play_answers/1.json
  def update
    respond_to do |format|
      if @play_answer.update(play_answer_params)
        format.html { redirect_to @play_answer, notice: 'Play answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @play_answer }
      else
        format.html { render :edit }
        format.json { render json: @play_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /play_answers/1
  # DELETE /play_answers/1.json
  def destroy
    @play_answer.destroy
    respond_to do |format|
      format.html { redirect_to play_answers_url, notice: 'Play answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play_answer
      @play_answer = PlayAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_answer_params
      params[:play_answer]
    end
end
