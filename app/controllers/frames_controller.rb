class FramesController < ApplicationController
  before_action :set_frame, only: [:show, :update, :destroy]

  # GET /frames
  def index
    @frames = Frame.all
  end

  # GET /frames/1
  def show
  end

  # POST /frames
  def create
    @frame = Frame.new(frame_params)

    respond_to do |format|
      if @frame.save
        format.json { render :show, status: :created, location: @frame }
      else
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frames/1
  def update
    respond_to do |format|
      if @frame.update(frame_params)
        format.json { render :show, status: :ok, location: @frame }
      else
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frames/1
  def destroy
    @frame.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_frame
      @frame = Frame.find(params[:id])
    end

    def frame_params
      params.require(:frame).permit(:game_id, :player_id, :shot_1, :shot_2, :shot_3, :number)
    end
end
