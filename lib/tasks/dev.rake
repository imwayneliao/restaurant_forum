namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "/seed_img/#{rand(1..21)}.jpg"))
      )
    end

    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      User.create!(
        name: FFaker::Name.name,
        email: FFaker::Internet.email,
        password: "a123456",
        intro: FFaker::Lorem.paragraph)
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end
  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
          )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end
end