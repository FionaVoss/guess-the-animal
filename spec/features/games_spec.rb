require 'rails_helper'
require 'testing_methods'

RSpec.feature "Games", type: :feature do
  context "playing the game" do
    Steps "playing the game with no animals in the database" do
      Given "I am on the landing page" do
        visit "/"
        expect(page).to have_content "Think of an animal. When you're ready, click the button and I'll try to guess it."
      end
      Then "I can start the game by clicking a button" do
        click_link "I'm ready!"
      end
      And "I am asked to submit an animal" do
        expect(page).to have_content "I don't have any animals! Please give me one so we can get started"
        fill_in 'animal_field', with: "tiger"
        click_button 'Submit'
      end
      And "the animal is added to the database" do
        expect(Animal.first.name).to eq 'tiger'
      end
      And 'I am redirected to the landing page' do
        expect(page).to have_content 'Guess the animal'
      end
    end
    Steps "losing the game with one animal in the database" do
      Given "there is one animal in the database" do
        create_animal("tiger")
      end
      And 'I have started the game' do
        visit "/"
        click_link "I'm ready!"
      end
      Then "I am asked if that's my animal" do
        expect(page).to have_content "Is it a tiger?"
      end
      And "if I click 'yes'" do
        click_link 'Yes, you win!'
      end
      Then "I am asked to play again" do
        expect(page).to have_content "Yay, I win! Thanks for playing. Click the button to play again."
      end
    end
  end
end
