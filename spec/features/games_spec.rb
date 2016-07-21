require 'rails_helper'

RSpec.feature "Games", type: :feature do
  context "playing the game" do
    Steps "playing the game with no animals in the database" do
      Given "I am on the landing page" do
        visit "/"
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
  end
end
