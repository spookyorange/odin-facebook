# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'haha@haha', password: 'fsadasdadsa')
User.create(email: 'papa@papa', password: 'sadasfasdadsa')
User.create(email: 'asdjasfa@faskda', password: 'asdjaskndfkaflmk')

Profile.create(user_id: User.first.id, username: 'cool-pal')
Profile.create(user_id: User.second.id, username: 'real-cool-pal')
Profile.create(user_id: User.third.id,  username: 'little-god')
