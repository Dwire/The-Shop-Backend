# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  User.create({name: "Greg", email: "g@g.com", password: "win", guru: "React JS", project: "Rails Api with a React Redux Front End"})

  Post.create({title: "Trying Talk Shop", body: "stuck on a few problems if any programers are in the area and want to talk shop", topic: "Talk Shop", user_id: 1})
