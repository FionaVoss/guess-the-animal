class GameController < ApplicationController
  def play
  end

  def start
    if Animal.count == 0
      redirect_to "/game/new_animal"
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
end
