# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

data = JSON.parse(File.read(Rails.root.join('data.json')))

data.each do |record|
  Person.create(
    name: record['name'],
    detail_attributes: {
      title: record['info']['title'],
      email: record['info']['email'],
      age: record['info']['age'],
      phone: record['info']['phone']
    }
  )
end