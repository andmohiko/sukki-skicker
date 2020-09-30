# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Skicker.create!(
  [
    {
      name: 'タップ',
      power: 1,
      cost: 0
    },
    {
      name: 'ぺこぺこ',
      power: 2,
      cost: 15
    },
    {
      name: 'ひもぺち',
      power: 5,
      cost: 30
    },
    {
      name: 'はりせん',
      power: 10,
      cost: 80
    },
    {
      name: 'クラッカー',
      power: 30,
      cost: 200
    },
    {
      name: '湯呑み',
      power: 50,
      cost: 500
    },
    {
      name: 'うに',
      power: 80,
      cost: 1000
    },
    {
      name: 'カジキマグロ',
      power: 160,
      cost: 5000
    },
  ]
)