# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Member.create!(member_name: "Example User",
								member_email: "example@gmail.com",
								member_country: "Nepal",
								password: "foobar",
								password_confirmation: "foobar",
								admin: true,
								activated: true,
								activated_at: Time.zone.now)

10.times do |n|
	member_name = Faker::Name.name
	member_email = "example-#{n+1}@gmail.com"
	member_country = Faker::Address.country
	password = "password"
	Member.create!(member_name: member_name,
									member_email: member_email,
									member_country: member_country,
									password: password,
									password_confirmation: password, 
									activated: true,
									activated_at: Time.zone.now)
end