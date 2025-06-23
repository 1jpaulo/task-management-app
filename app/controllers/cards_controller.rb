class CardsController < ApplicationController
  before_action :current_user
  before_action :set_card, only: %i[ show update destroy ]

  def index
    @cards = Card.all
  end

  def show
  end

  def card
    @card = @user.cards.build
  end

  def create
    @card = @user.cards.new(card_params)

    unless @card.save
      # TODO: Rather use hotwire approach than json error messages
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render json: { status: :ok }
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy!

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = @user.cards.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:title, :text)
    end
end
