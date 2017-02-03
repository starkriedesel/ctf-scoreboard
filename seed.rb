def seed!
  puts "Seeding users"
  User.all.delete
  admin = User.create!({name: 'admin', email: 'admin@example.com', password: 'admin', hide: true})
  user1 = User.create!({name: 'user1', email: 'user1@example.com', password: 'user', affiliation: 'SMU'})
  user2 = User.create!({name: 'user2', email: 'user2@example.com', password: 'user', affiliation: 'UTD'})
  user3 = User.create!({name: 'user3', email: 'user3@example.com', password: 'user', affiliation: 'UNT'})
  user4 = User.create!({name: 'user4', email: 'user4@example.com', password: 'user', affiliation: 'Cigital'})
  user5 = User.create!({name: 'user5', email: 'user5@example.com', password: 'user'})

  puts "Seeding tracks"
  Track.all.delete
  windows = Track.create!({name: 'Windows', color: 'blue', order: 1, diagram: '/windows_network.svg'})
  linux   = Track.create!({name: 'Linux',   color: 'orange', order: 2})
  web     = Track.create!({name: 'Web',     color: 'green', order: 3})
  iot     = Track.create!({name: 'IoT',     color: 'purple', order: 5})
  crypto  = Track.create!({name: 'Crypto',  color: 'red', order: 4})
  other   = Track.create!({name: 'Other',   color: 'red', order: 5})

  puts "Seeding flag"
  Flag.all.delete
  windows10 = Flag.create!({name: 'Access', points: 10, track: windows, value: 'flag{Win1}', order: 1})
  windows20 = Flag.create!({name: 'Snoop', points: 20, track: windows, value: 'flag{Win2}', order: 2})
  windows30 = Flag.create!({name: 'Piviot', points: 30, track: windows, value: 'flag{Win3}', order: 3})
  windows40 = Flag.create!({name: 'Escelate',  points: 40, track: windows, value: 'flag{Win4}', order: 4})
  windows50 = Flag.create!({name: 'Domain', points: 50, track: windows, value: 'flag{Win5}', order: 5})
  linux10   = Flag.create!({points: 10, track: linux, value: 'flag{Linux1}', order: 1})
  linux20   = Flag.create!({points: 20, track: linux, value: 'flag{Linux2}', order: 2})
  linux30   = Flag.create!({points: 30, track: linux, value: 'flag{Linux3}', order: 3})
  linux40   = Flag.create!({points: 40, track: linux, value: 'flag{Linux4}', order: 4})
  linux50   = Flag.create!({points: 50, track: linux, value: 'flag{Linux5}', order: 5})
  web10     = Flag.create!({points: 10, track: web, value: 'flag{Web1}', order: 1})
  web20     = Flag.create!({points: 20, track: web, value: 'flag{Web2}', order: 2})
  web30     = Flag.create!({points: 30, track: web, value: 'flag{Web3}', order: 3})
  iot10     = Flag.create!({points: 10, track: iot, value: 'flag{Iot1}', order: 1})
  iot20     = Flag.create!({points: 20, track: iot, value: 'flag{Iot2}', order: 2})
  iot30     = Flag.create!({points: 30, track: iot, value: 'flag{Iot3}', order: 3})
  crypto10  = Flag.create!({points: 10, track: crypto, value: 'flag{Crypto1}', order:1})
  crypto20  = Flag.create!({points: 20, track: crypto, value: 'flag{Crypto2}', order:1})
  crypto30  = Flag.create!({points: 30, track: crypto, value: 'flag{Crypto3}', order:1})

  puts "Seeding completed flags"
  user1.flags << windows10
  user1.flags << linux10
  user1.flags << linux20
  user2.flags << linux10
  user2.flags << web10
  user1.flags << web10
  user3.flags << iot10
  user3.flags << iot20
  user3.flags << iot30
  user3.flags << web10
  user1.update_score
  user2.update_score
  user3.update_score
end
