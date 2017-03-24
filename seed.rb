def seed!
  full_seed!
  update_seed!
end

def update_seed!
end

def clear!
  User.all.delete
  Track.all.delete
  Flag.all.delete
end

def full_seed!
  puts "Clearing db"
  clear!

  puts "Seeding users"
  admin = User.create!({name: 'admin', password: 'admin', hide: true})

  puts "Seeding tracks"
  windows    = Track.create!({name: 'Windows', color: 'blue', order: 1, diagram: '/windows_network.svg'})
  linux      = Track.create!({name: 'Linux',   color: 'orange', order: 2})
  web        = Track.create!({name: 'Challenge',     color: 'green', order: 3})
  crypto     = Track.create!({name: 'Challenge',     color: 'green', order: 4})
  reversing  = Track.create!({name: 'Challenge',     color: 'green', order: 5})
  other      = Track.create!({name: 'Other',   color: 'red', order: 6})

  puts "Seeding flag"

  # Windows Flags

  # Linux Flags
  Flag.create!({name: 'Recon', points: 10, track: linux, value: 'FLAG{xyz}', order: 1})
  Flag.create!({name: 'R00t', points: 10, track: linux, value: 'FLAG{abc}', order: 2})

  # Crypto Flags
  Flag.create!({name: 'Brute', points: 10, track: crypto, value: 'FLAG{crypto1}', order: 1})
  Flag.create!({name: '^Enc', points: 10, track: crypto, value: 'FLAG{crypto2}', order: 2})
  Flag.create!({name: 'Rand', points: 10, track: crypto, value: 'FLAG{crypto3}', order: 3})
  Flag.create!({name: 'OTP', points: 10, track: crypto, value: 'FLAG{crypto4}', order: 4})

  # Reversing Flags
  Flag.create!({name: 'BASIC', points: 10, track: reversing, value: 'FLAG{reversing1}', order: 1})
  Flag.create!({name: 'GDB', points: 10, track: reversing, value: 'FLAG{reversing2}', order: 2})
  Flag.create!({name: 'APK', points: 10, track: reversing, value: 'FLAG{reversing3}', order: 3})

  # Web Flags
  Flag.create!({name: 'SQLi 1', points: 10, track: reversing, value: 'FLAG{web1}', order: 1})
  Flag.create!({name: 'SQLi 2', points: 10, track: reversing, value: 'FLAG{web2}', order: 2})
  Flag.create!({name: 'MongoDB 1', points: 10, track: reversing, value: 'FLAG{web3', order: 3})
  Flag.create!({name: 'MongoDB 2', points: 10, track: reversing, value: 'FLAG{web4}', order: 4})
  Flag.create!({name: 'PHP', points: 10, track: reversing, value: 'FLAG{web5}', order: 5})

  # Other Flags

  puts "Seeding completed flags"
end
