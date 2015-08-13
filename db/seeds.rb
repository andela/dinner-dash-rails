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

U1 = User.create(
    first_name: "Damilola",
    last_name: "Roberts",
    email: "dr@yahoo.com",
    password: "whatever",
    password_confirmation: "whatever"
  )

U2 = User.create(
    first_name: "Jeff",
    last_name: "Roberts",
    email: "jr@yahoo.com",
    password: "whatever",
    password_confirmation: "whatever"
  )

O1 = Order.create(Status: "Completed", user_id: U1.id)
O2 = Order.create(Status: "Cancelled", user_id: U1.id)
O3 = Order.create(Status: "Processing")

Order_Item1 = OrderItem.create(quantity: 3, food_id: F1.id, order_id: 1)
Order_Item2 = OrderItem.create(quantity: 2, food_id: F2.id, order_id: 1)
Order_Item3 = OrderItem.create(quantity: 5, food_id: F3.id, order_id: 1)

Order_Item4 = OrderItem.create(quantity: 4, food_id: F3.id, order_id: 2)



C1.foods << F1
C2.foods << F3
