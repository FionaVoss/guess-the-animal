class GameController < ApplicationController
  def play
    @message = "Think of an animal. When you're ready, click the button and I'll try to guess it."
  end

  def start
    if Animal.count == 0
      redirect_to "/game/new_animal"
    else
      redirect_to "/game/guess"
    end
  end

  def new_animal
  end

  def create_animal
    new_animal = Animal.new
    new_animal.name = params[:animal_field]
    new_animal.save
    redirect_to '/'
  end

  def guess
    @guess = Animal.first.name
  end

  def win
    @message = "Yay, I win! Thanks for playing. Click the button to play again."
    render '/game/play'
  end
end
