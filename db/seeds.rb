# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Match.destroy_all()
User.destroy_all()
User.create([{provider: nil, uid: nil, name: 'T+I Proyecta', oauth_token: nil, oauth_expires_at: nil, created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00', email: 'ti@trabajosproyecta.cl', phone_number: '+56959333263', password_digest: 'alobchi2020', is_admin: true, id_mod: true}])
User.create([{provider: nil, uid: nil, name: 'Financiamiento Proyecta', oauth_token: nil, oauth_expires_at: nil, created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00', email: 'financiamiento@trabajosproyecta.cl', phone_number: '+56959333263', password_digest: 'alobchi2020', is_admin: false, id_mod: true}])
# Match.create([{team_1_name: 'br', team_2_name: 'bo', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-14 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 've', team_2_name: 'pe', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-15 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'ar', team_2_name: 'co', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-15 19:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'py', team_2_name: 'qa', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-16 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'uy', team_2_name: 'ec', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-16 19:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'jp', team_2_name: 'cl', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-17 20:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'br', team_2_name: 've', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-18 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'bo', team_2_name: 'pe', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-18 18:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'ar', team_2_name: 'py', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-19 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'co', team_2_name: 'qa', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-19 18:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'uy', team_2_name: 'jp', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-20 20:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'ec', team_2_name: 'cl', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-21 20:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'pe', team_2_name: 'br', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-22 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'bo', team_2_name: 've', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-22 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'qa', team_2_name: 'ar', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-23 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'co', team_2_name: 'py', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-23 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'cl', team_2_name: 'uy', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-24 20:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'pe', team_2_name: 'br', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-22 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
# Match.create([{team_1_name: 'ec', team_2_name: 'jp', team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-14 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-27 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-28 20:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-28 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-06-29 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-07-02 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-07-03 21:30:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-07-06 16:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
Match.create([{team_1_result: -1, team_2_result: -1, edited: 0, date: '2019-07-07 17:00:00', created_at: '2019-05-17 00:58:00', updated_at: '2019-05-17 00:58:00'}])
