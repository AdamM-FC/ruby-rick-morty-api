# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

location1 = Location.create!(name: 'Earth',
                             location_type: 'Planet',
                             dimension: 'Dimension C-137',
                             url: 'https://rickandmortyapi.com/api/location/1')

location2 = Location.create!(name: '(Replacement Dimension))',
                             location_type: 'Planet',
                             dimension: 'Replacement dimension',
                             url: 'https://rickandmortyapi.com/api/location/20')

character = Character.create!(name: 'Rick',
                              status: 'Alive',
                              species: 'Human',
                              gender: 'Male',
                              character_type: 'human',
                              image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                              location_id: location1.id,
                              origin_id: location2.id)

episode = Episode.create!(name: 'Pilot',
                          episode: 'S01E01',
                          air_date: '2000-01-01 11:46:25',
                          url: 'https://rickandmortyapi.com/api/episode/1')

character.episodes << episode