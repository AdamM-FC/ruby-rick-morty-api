# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

character = Character.create!(name: 'Rick',
    status: 'Alive',
    species: 'Human',
    gender: 'Male',
    character_type: 'human',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg')

episode = Episode.create!(name: 'Pilot',
episode: 'S01E01',
air_date: '2000-01-01 11:46:25',
url: '"https://rickandmortyapi.com/api/episode/1')

character.episodes << episode