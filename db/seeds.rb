# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


F1 = Food.create(
      name: "Spagetti bolognese",
      description: "Warm yummy spagetti to increase your life span!",
      price: 1500 )

F2 = Food.create(
      name: "Steaks",
      description: "Nice mix of african specials and barbecue sauce",
      price: 750 )

F3 = Food.create(name: "Lobsters",
      description: "Crispy sea food delicacy to make your holiday",
      price: 1200 )

C1 = Category.create(
    title: "Entree",
    description: "Home made food ready to eat")

C2 = Category.create(
    title: "Desserts",
    description: "Finger-licking desserts made from our great family recipe")

C1.foods << F1
C2.foods << F3
