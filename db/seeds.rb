# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Clearing users..."
User.destroy_all
puts "Clearing users..."

user1 = User.create(email: "zzz@gmail.com", password: "123123", username: "Rayz")
puts "Creating user1..."
user2 = User.create!(email: "yzyz@gmail.com", password: "321321", username: "Amy")
puts "Creating user2..."
user3 = User.create!(email: "wwyy@gmail.com", password: "123321", username: "Ruben")
puts "Creating user3..."
user4 = User.create!(email: "abc@gmail.com", password: "123321", username: "Sarah")
puts "Creating user4..."
user5 = User.create!(email: "cba@gmail.com", password: "123321", username: "Alex")
puts "Creating user5..."

# Create a desk

puts "Clearing desks..."
Desk.destroy_all

desk1 = Desk.create!(user: user1, title: "Rayz's Desk", points: 100)
desk2 = Desk.create!(user: user2, title: "Amy's Desk", points: 200)
desk3 = Desk.create!(user: user3, title: "Ruben's Desk", points: 300)
desk4 = Desk.create!(user: user4, title: "Sarah's Desk", points: 300)
desk5 = Desk.create!(user: user5, title: "Alex's Desk", points: 300)

# Create an event

puts "Clearing events..."
Event.destroy_all

event1 = Event.create!(title: "Meeting", start_time: DateTime.new(2025, 2, 11, 11, 0, 0), end_time: DateTime.new(2025, 2, 11, 11, 0, 0), desk: desk1)

event2 = Event.create!(title: "Lunch", start_time: DateTime.new(2025, 2, 11, 11, 0, 0), end_time: DateTime.new(2025, 2, 11, 11, 0, 0), desk: desk1)

event3 = Event.create!(title: "Sleeping", start_time: DateTime.new(2025, 2, 11, 11, 0, 0), end_time: DateTime.new(2025, 2, 11, 11, 0, 0), desk: desk1)

event4 = Event.create!(title: "Boxing", start_time: DateTime.new(2025, 2, 11, 11, 0, 0), end_time: DateTime.new(2025, 2, 11, 11, 0, 0), desk: desk1)
