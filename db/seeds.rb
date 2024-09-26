# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if !User.find_by(role: "admin").present?
  User.create!(
    first_name: 'admin',
    last_name: 'admin',
    email: "admin@gmail.com",
    password: "admin123456",
    password_confirmation: "admin123456",
    joining_date: Date.today,
    phone_number: "9428936537",
    address: "Marse",
    pincode: "36754",
    latest_degree: "PHD",
    role: "admin"
  )
end
