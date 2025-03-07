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

desk1 = Desk.create!(user: user1, title: "Building Chatbots", points: 100, interest: "Chatbots", question: "What is the best game you have?", intro: "Hi, I'm Rayz, and I'm trying to build the ultimate chatbot! One that listens, responds smartly, and doesn't sound like a robot from 1999. Can AI actually be a good conversationalist?")
desk2 = Desk.create!(user: user2, title: "AI for Productivity", points: 200, interest: "AI automation", question: "What's the best AI tool to fully automate daily workflows?", intro: "Yo! I'm Amy, a productivity geek who's trying to make AI do all my boring tasks so I can chill more. Can AI plan my schedule, reply to emails, and maybe even wake me up in the morning? Let's find out!")
desk3 = Desk.create!(user: user3, title: "Generative AI Art", points: 300, interest: "AI Art", question: "How do I train an AI model to create art that matches my personal style?", intro: "Hey, I'm Ruben! I paint, but now I'm making AI do the heavy lifting. Can AI create something that actually feels like real art, or is it just fancy randomness? Let's put it to the test!")
desk4 = Desk.create!(user: user4, title: "AI-Powered Coding", points: 300, interest: "AI Coding", question: "How do I train an AI to generate code in my personal coding style?", intro: "Hey there! I'm Sarah, a dev who's making AI my personal coding assistant. I love using Copilot and ChatGPT, but I want to push it further. Can I make AI write an entire app for me? 🤔")
desk5 = Desk.create!(user: user5, title: "AI for Language Learning", points: 300, interest: "Japanese", question: "What are the best AI-powered tools to improve speaking fluency?", intro: "こんにちは! (Hello!) I'm Alex, and I'm on a quest to learn Japanese faster. AI can generate voices, flashcards, and even chat in Japanese… but can it really help me become fluent?")
desk6 = Desk.create!(user: user6, title: "AI in Finance", points: 500, interest: "Investing", question: "How do hedge funds use AI in algorithmic trading?", intro: "Numbers, trends, and AI—my three obsessions! I'm Allan, and I want to see if AI can actually predict stock movements or if it's just fancy guesswork. Can I use AI to beat the market? 🤓")
desk7 = Desk.create!(user: user7, title: "AI Resume Builder", points: 600, interest: "Job hunting", question: "What's the best AI-powered resume tool for ATS optimization?", intro: "Hey there! I'm Mia, job hunting and tired of rewriting my resume for every position. Can AI finally fix this pain point? If it can land me my dream job, I'll worship it forever! 🙌")
desk8 = Desk.create!(user: user8, title: "AI Writing Assistant", points: 600, interest: "Blogging", question: "How do I get AI to write in my unique tone and voice?", intro: "I love writing, but I hate writer's block! 😩 I'm Minami, and I'm testing AI to see if it can help me write faster, better, and smarter—without making me sound like a robot.")
desk9 = Desk.create!(user: user9, title: "Mastering Prompt Engineering", points: 600, interest: "Prompting", question: "What's the best framework for optimizing AI prompts across different models?", intro: "Hi, I'm Cindy! I'm obsessed with crafting perfect prompts to make AI do what I want. It's like magic! Can I find the ultimate way to unlock the full power of AI?")
desk10 = Desk.create!(user: user10, title: "Cooking & Food Experiments", points: 600, interest: "Cooking", question: "What's the secret to making restaurant-quality ramen at home?", intro: "I love food! I'm Liam, and I'm always trying out new recipes (sometimes they work… sometimes they explode). Can I make the perfect homemade ramen?")
desk11 = Desk.create!(user: user11, title: "Fitness & Strength Training", points: 600, interest: "Fitness", question: "Is progressive overload really the best method for muscle growth?", intro: "Gym rat alert! 🏋️‍♂️ I'm Nico, and I'm trying to level up my strength. What's the best way to build muscle fast without wrecking my body?")
desk12 = Desk.create!(user: user12, title: "Traveling the World", points: 600, interest: "Travel", question: "What are the best underrated travel destinations for 2025?", intro: "I'm Julian, and I want to see everything. From street food in Tokyo to hidden beaches in Greece, I'm on a mission to explore the world. 🌎")
desk13 = Desk.create!(user: user13, title: "Playing the Guitar", points: 600, interest: "Guitar", question: "What's the best way to improve fingerpicking speed on the guitar?", intro: "Hey, I'm Lio! Just a guy trying to play cool riffs without making my neighbors hate me. Can I master a killer solo before the year ends? 🎶")
desk14 = Desk.create!(user: user14, title: "Psychology & Human Behavior", points: 600, interest: "Psychology", question: "What's the psychology behind why people form habits?", intro: "I'm Jakub, and I'm fascinated by how the human brain works. Why do people make irrational choices? And why do I always procrastinate? 😂")
desk15 = Desk.create!(user: user15, title: "Film & Movie Analysis", points: 600, interest: "Movies", question: "What are the best films that break traditional storytelling structures?", intro: "I'm Ben, and I live for movies. 🍿 From deep analysis to just laughing at bad films, I'm here to explore storytelling and cinematography!")
desk16 = Desk.create!(user: user16, title: "Learning a New Dance", points: 600, interest: "Dance", question: "What's the easiest dance style for complete beginners?", intro: "I have two left feet, but I'm determined to learn how to dance! I'm Max, and I want to go from awkward shuffling to actually looking cool. 😎")
desk17 = Desk.create!(user: user17, title: "Writing a Novel", points: 600, interest: "Writing", question: "How do I create realistic and compelling characters?", intro: "I have a thousand ideas in my head, but can I turn them into an actual book? I'm Stamati, and I'm on a mission to finally finish my first novel!")
desk18 = Desk.create!(user: user18, title: "Gardening & Plant Care", points: 600, interest: "Gardening", question: "What's the best way to revive an overwatered plant?", intro: "Plants are my babies. 🌿 I'm Jas, and I'm obsessed with making my tiny garden thrive. Can I finally keep my basil plant alive this time? 😂")

# Create an event

puts "Clearing events..."


puts "Clearing rooms..."
Room.destroy_all
puts "Clearing spots..."
Spot.destroy_all

room0 = Room.create!(title: "AI for Everday Lives", description: "Studying the use of AI for everyday lives involves exploring how artificial intelligence can simplify and enhance various aspects of daily activities. This research delves into the development of AI-powered technologies that can improve efficiency in tasks such as home automation, healthcare, transportation, and personal assistance.", user: user1, public: true, locked: false)
room1 = Room.create!(title: "Meeting", description: "Let's talk about Marvel movies, that will be fun!", user: user1, public: true, locked: false)
room2 = Room.create!(title: "Movie", description: "Let's talk about Marvel movies, that will be fun!", user: user2, public: true, locked: false)
room3 = Room.create!(title: "Algorithm", description: "Let's talk about Marvel movies, that will be fun!", user: user3, public: true, locked: false)
room4 = Room.create!(title: "Boxing", description: "Let's talk about Marvel movies, that will be fun!", user: user2, public: true, locked: false)
room5 = Room.create!(title: "Boxing2", description: "Let's talk about Marvel movies, that will be fun!", user: user1, public: false, locked: false)
room6 = Room.create!(title: "AI Content Generation", description: "Studying AI content generation involves exploring how artificial intelligence technologies can be leveraged to create and optimize written content. This field of study delves into the various algorithms, models, and tools that can be used to generate high-quality and engaging text for a wide range of purposes, from marketing and advertising to journalism and storytelling.", user: user2, public: true, locked: false)




# spot1 = Spot.create!(status: :accepted, room: room1, user: user2)
# spot2 = Spot.create!(status: "pending", room: room2, user: user3)
# spot3 = Spot.create!(status: "pending", room: room3, user: user1)
# spot4 = Spot.create!(status: "pending", room: room4, user: user1)

users = [user1, user2, user3, user4, user5, user6, user7, user8, user9,
user10,user11,user12,user13,user14,user15,user16,user17,user18]


users.each do |user|
  if user == user1
    next
  end
  Spot.create!(status: :accepted, room: room0, user: user)
end

users.each do |user|
  if user == user1
    next
  end
  Spot.create!(status: :accepted, room: room6, user: user)
end
