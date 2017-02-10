# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users
u1 = User.new(name: "Joe", email: "joe@example.com", password: "password", role: 'premium')
u1.skip_confirmation!
u1.save!

u2 = User.new(name: "Kelly", email: "kelly@example.com", password: "password", role: 'premium')
u2.skip_confirmation!
u2.save!

u3 = User.new(name: "Bill", email: "bill@example.com", password: "password")
u3.skip_confirmation!
u3.save!

u4 = User.new(name: "Mike", email: "mike@example.com", password: "password")
u4.skip_confirmation!
u4.save!

users = [u1,u2, u3, u4]
premium_users = [u1, u2]

u5 = User.new(name: "Admin", email: "admin@example.com", password: "password", role: 'admin')
u5.skip_confirmation!
u5.save!

# public wikis
1.upto(20) do
	user = users.sample
	Wiki.create(title: "#{Faker::Hipster.sentence} -- public by #{user.name}", body: Faker::Hipster.paragraph, user: user )
end

# private wikis
1.upto(10) do 
	premium_user = premium_users.sample
	Wiki.create(title: "#{Faker::Hipster.sentence} -- private by #{premium_user.name}", body: Faker::Hipster.paragraph, user: premium_user, private: true)
end


puts "*".center(40,"*")
puts 
puts "#{Wiki.count} all wikis created".center(40," ")
puts "#{Wiki.where(private: false).count} public wikis created".center(40," ")
puts "#{Wiki.where(private: true).count} private wikis created".center(40," ")
puts "#{User.standard.count} standard users created".center(40," ")
puts "#{User.premium.count} premium users created".center(40," ")
puts "#{User.admin.count} admin users created".center(40," ")
puts " Done seeding ".center(40," ")
puts 
puts "*".center(40,"*")




