require 'faker'

# Create Users
users = User.all
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10),
    )
    user.skip_confirmation!
    user.save!
end

# Create an admin user
admin = User.new(
  name: 'Admin Man',
  email: 'admin@example.com',
  password: 'helloworld',
  )
admin.skip_confirmation!
admin.save!

# Create To Do's
items=Item.all
40.times do
  Item.create!(
    name: Faker::Lorem.sentence,
    user: users.sample,
    created_at: Faker::Date.between(20.days.ago, Date.today) #Interesting to generate expired entries
    # Can you use an IF statement in Faker -> If created_at +7.days THEN make status expired
    )
end

items=Item.all
5.times do
  Item.create!(
    name: Faker::Lorem.sentence,
    user: User.find(11),
    created_at: Faker::Date.backward(20) #Interesting to generate expired entries
    # Can you use an IF statement in Faker -> If created_at +7.days THEN make status expired
    )
end

items=Item.all
5.times do
  Item.create!(
    name: Faker::Lorem.sentence,
    user: User.find(11),
    created_at: Faker::Date.between(6.days.ago, Date.today) #Interesting to generate expired entries
    # Can you use an IF statement in Faker -> If created_at +7.days THEN make status expired
    )
end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Item.count} To Do's created"

