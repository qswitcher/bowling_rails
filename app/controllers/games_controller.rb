class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  def_param_group :game do
    param :game, Hash, required: true do
      param :name, String, desc: 'The of the :resource'
    end
  end

  resource_description do
    formats ['json']
    description <<-EOS
      The entity representing a single bowling game.
    EOS
  end

  # GET /games
  api! 'Lists all games'
  def index
    @games = Game.all
  end

  # GET /games/1
  api! 'Returns the details of a specific game'
  def show
  end

  # POST /games
  api! 'Creates a game'
  param_group :game
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.json { render :show, status: :created, location: @game }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  api! 'Updates a game'
  param_group :game
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.json { render :show, status: :ok, location: @game }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  api! 'Deletes a game'
  def destroy
    @game.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name)
    end
end
