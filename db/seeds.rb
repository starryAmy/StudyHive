# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Event.destroy_all
puts "Clearing users..."
User.destroy_all

puts "Creating users..."
user1 = User.create(email: "rayz@gmail.com", password: "123456", username: "Rayz")
user2 = User.create!(email: "amy@gmail.com", password: "123456", username: "Amy")
user3 = User.create!(email: "ruben@gmail.com", password: "123456", username: "Ruben")
user4 = User.create!(email: "sarah@gmail.com", password: "123456", username: "Sarah")
user5 = User.create!(email: "alex@gmail.com", password: "123456", username: "Alex")
user6 = User.create!(email: "allan@gmail.com", password: "123456", username: "Allan")
user7 = User.create!(email: "mia@gmail.com", password: "123456", username: "Mia")
user8 = User.create!(email: "minami@gmail.com", password: "123456", username: "Minami")
user9 = User.create!(email: "cindy@gmail.com", password: "123456", username: "Cindy")
user10 = User.create!(email: "liam@gmail.com", password: "123456", username: "Liam")
user11 = User.create!(email: "nico@gmail.com", password: "123456", username: "Nico")
user12 = User.create!(email: "julian@gmail.com", password: "123456", username: "Julian")
user13 = User.create!(email: "lio@gmail.com", password: "123456", username: "Lio")
user14 = User.create!(email: "jakub@gmail.com", password: "123456", username: "Jakub")
user15 = User.create!(email: "ben@gmail.com", password: "123456", username: "Ben")
user16 = User.create!(email: "max@gmail.com", password: "123456", username: "Max")
user17 = User.create!(email: "stamati@gmail.com", password: "123456", username: "Stamati")
user18 = User.create!(email: "jas@gmail.com", password: "123456", username: "Jas")

# Create a desk

puts "Clearing desks..."
Desk.destroy_all

desk1 = Desk.create!(user: user1, title: "Making Games!!!Rock", points: 100, task: "Finish the game", interest: "Game", question: "What is the best game you have?", intro: "I am a game developer")
desk2 = Desk.create!(user: user2, title: "Preparing Interview", points: 200, task: "Finish the interview", interest: "Game", question: "What is the best game you have?", intro: "I am a game developer")
desk3 = Desk.create!(user: user3, title: "Dating tips", points: 300, task: "Finish the date")
desk4 = Desk.create!(user: user4, title: "Programming", points: 300, task: "Finish the code")
desk5 = Desk.create!(user: user5, title: "Programming", points: 300, task: "Finish the code")
desk6 = Desk.create!(user: user6, title: "Tiredddd", points: 500, task: "Preview material")
desk7 = Desk.create!(user: user7, title: "Damn exam", points: 600, task: "Practice exams")
desk8 = Desk.create!(user: user8, title: "Damn exam", points: 600, task: "Practice exams")
desk9 = Desk.create!(user: user9, title: "Damn exam", points: 600, task: "Practice exams")
desk10 = Desk.create!(user: user10, title: "Damn exam", points: 600, task: "Practice exams")
desk11 = Desk.create!(user: user11, title: "Damn exam", points: 600, task: "Practice exams")
desk12 = Desk.create!(user: user12, title: "Damn exam", points: 600, task: "Practice exams")
desk13 = Desk.create!(user: user13, title: "Damn exam", points: 600, task: "Practice exams")
desk14 = Desk.create!(user: user14, title: "Damn exam", points: 600, task: "Practice exams")
desk15 = Desk.create!(user: user15, title: "Damn exam", points: 600, task: "Practice exams")
desk16 = Desk.create!(user: user16, title: "Damn exam", points: 600, task: "Practice exams")
desk17 = Desk.create!(user: user17, title: "Damn exam", points: 600, task: "Practice exams")
desk18 = Desk.create!(user: user18, title: "Damn exam", points: 600, task: "Practice exams")

# Create an event

puts "Clearing events..."


puts "Clearing rooms..."
Room.destroy_all
puts "Clearing spots..."
Spot.destroy_all

room0 = Room.create!(title: "AI", description: "Let's talk about AI, yayyy!!!", user: user1, public: true, locked: false)
room1 = Room.create!(title: "Meeting", description: "Let's talk about Marvel movies, that will be fun!", user: user1, public: true, locked: false)
room2 = Room.create!(title: "Movie", description: "Let's talk about Marvel movies, that will be fun!", user: user2, public: true, locked: false)
room3 = Room.create!(title: "Algorithm", description: "Let's talk about Marvel movies, that will be fun!", user: user3, public: true, locked: false)
room4 = Room.create!(title: "Boxing", description: "Let's talk about Marvel movies, that will be fun!", user: user2, public: true, locked: false)
room5 = Room.create!(title: "Boxing2", description: "Let's talk about Marvel movies, that will be fun!", user: user1, public: false, locked: false)
room6 = Room.create!(title: "Boxing3", description: "Let's talk about Marvel movies, that will be fun!", user: user2, public: false, locked: false)




spot1 = Spot.create!(status: :accepted, room: room1, user: user2)
spot2 = Spot.create!(status: "pending", room: room2, user: user3)
spot3 = Spot.create!(status: "pending", room: room3, user: user1)
spot4 = Spot.create!(status: "pending", room: room4, user: user1)
