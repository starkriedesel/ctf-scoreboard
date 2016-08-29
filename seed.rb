def seed!
  puts "Seeding users"
  User.all.delete
  admin = User.create!({name: 'admin', email: 'admin@example.com', password: 'admin'})

  puts "Seeding tracks"
  Track.all.delete
  windows = Track.create!({name: 'Windows', color: 'blue', order: 2, diagram: '/windows_network.svg'})
  linux   = Track.create!({name: 'Linux',   color: 'orange', order: 3})
  web     = Track.create!({name: 'Web',     color: 'green', order: 4})
  iot     = Track.create!({name: 'IoT',     color: 'purple', order: 1})

  puts "Seeding flag"
  Flag.all.delete
  windows10 = Flag.create!({points: 10, track: windows, value: 'flag{Win1}', order: 1})
  windows20 = Flag.create!({points: 20, track: windows, value: 'flag{Win2}', order: 2})
  windows30 = Flag.create!({points: 30, track: windows, locked: true, value: 'flag{Win3}', order: 3})
  windows30 = Flag.create!({points: 40, track: windows, locked: true, value: 'flag{Win4}', order: 4})
  linux10   = Flag.create!({points: 10, track: linux, value: 'flag{Linux1}', order: 1})
  linux20   = Flag.create!({points: 20, track: linux, value: 'flag{Linux2}', order: 2})
  linux30   = Flag.create!({points: 30, track: linux, locked: true, value: 'flag{Linux3}', order: 3})
  web10     = Flag.create!({points: 10, track: web, value: 'flag{Web1}', order: 1})
  web20     = Flag.create!({points: 20, track: web, value: 'flag{Web2}', order: 2})
  web30     = Flag.create!({points: 30, track: web, value: 'flag{Web3}', locked: true, order: 3})
  iot10     = Flag.create!({points: 10, track: iot, value: 'flag{Iot1}', order: 1})
  iot20     = Flag.create!({points: 20, track: iot, value: 'flag{Iot2}', order: 2})
  iot30     = Flag.create!({points: 30, track: iot, value: 'flag{Iot3}', locked: true, order: 3})

  puts "Seeding completed flags"
  admin.flags << windows10
  admin.flags << linux10
  admin.flags << web10
  admin.flags << iot10
  admin.update_score
end
