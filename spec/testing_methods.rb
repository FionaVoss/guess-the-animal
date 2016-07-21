def create_animal(new_name)
  new_animal = Animal.new
  new_animal.name = new_name
  new_animal.save
end
