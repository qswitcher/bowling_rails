class FramesController < ApplicationController
  before_action :set_frame, only: [:show, :update, :destroy]

  def_param_group :frame do
    param :frame, Hash, required: true do
      param :game_id, Integer, desc: 'Game ID', required: true
      param :player_id, Integer, desc: 'Player ID', required: true
      param :shot_1, Integer, desc: 'Number of pins knocked down in first roll', allow_nil: true
      param :shot_2, Integer, desc: 'Number of pins knocked down in second roll', allow_nil: true
      param :shot_3, Integer, desc: 'Number of pins knocked down in third roll (only applicable for the tenth frame)', allow_nil: true
    end
  end

  resource_description do
    formats ['json']
    description <<-EOS
      A <tt>Frame</tt> represents a single frame in a bowling game for a particular player.
      To score a particular frame, create a new <tt>Frame</tt> and specify the number of pins knocked down per shot by setting
      the <tt>shot_1</tt>, <tt>shot_2</tt>, and <tt>shot_3</tt> attributes. The shots for any roll may be <tt>nil</tt> and updated
      later via a PUT operation.

      The <b>GET</b> operation will return the number of pins knocked down per shot as well as the score for the frame and
      the cumulative score for the player up to and including the current frame.
    EOS
  end

  # GET /frames
  api! 'Lists all frames for all games'
  def index
    @frames = Frame.all
  end

  # GET /frames/1
  api! 'Returns a specific frame'
  def show
  end

  # POST /frames
  api! 'Creates a new frame'
  param_group :frame
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
  api! 'Updates an existing frame'
  param_group :frame
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
  api! 'Deletes a frame'
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
