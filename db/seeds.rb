# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "admin", email: "admin", password: "admin", password_confirmation: "admin", phone: "+49 150 123 45 67", admin: true)

10.times { |i| User.create(name: "John_#{i}",
                           email: "john_#{i}@doe.com",
                           password: "foobar",
                           password_confirmation: "foobar",
                           phone: "+49 150 123 45 67") }

@training = Event.create(category: 'Training', remark: '15 Min frueher wg. Aufwaermen', base_date: Date.today, base_time: '20:00', end_date: Date.today.advance(months: 3), place: 'Thedenstr., Hamburg')
#  if @training.save
    interval = (@training.base_date..@training.end_date).step(7).to_a
    interval.each { |i| Recurrence.create(:event_id => @training.id, :scheduled_to => i) }
#  end

playday_list = [
  [ '3.Spieltag','SCN/AlTSV/GWE','27.10.2012','14:30','27.10.2012','20:00','Pellwormstrasse 35, Norderstedt' ],
  [ '4.Spieltag','AlTSV/NTSV/Halst','04.11.2012','14:30','04.11.2012','20:00','Thadenstrasse 147' ],
  [ '5.Spieltag','Halst/NTSV/AlTSV','17.11.2012','14:30','17.11.2012','20:00','Feldstrasse 26, Halstenbek' ],
  [ '6.Spieltag','Blank/AlTSV/NTSV','25.11.2012','14:30','25.11.2012','20:00','Karstenstr. 22, Hamburg' ],
  [ '7.Spieltag','AlTSV/AFC/SCN','08.12.2012','14:30','08.12.2012','20:00','Thadenstrasse 147, Hamburg' ],
  [ '8.Spieltag','FSVH/NTSV/AlTSV','12.01.2013','14:30','12.01.2013','20:00','Baererstrasse 45, Harburg' ],
  [ '9.Spieltag','AlTSV/Blank/GWE','26.01.2013','14:30','26.01.2013','20:00','Thadenstrasse 147 Hamburg' ],
  [ '10.Spieltag','AlTSV/VGE/FSVH','02.02.2013','14:30','02.02.2013','20:00','Thadenstrasse 147, Hamburg' ],
  [ '11.Spieltag','VGE/AlTSV/Halst','10.02.2013','14:30','10.02.2013','20:00','Astrid-Lindgren-Schule, Koellner Chaussee 10b, Elmshorn' ],
  [ '12.Spieltag','NTSV/AlTSV/AFC','24.02.2013','14:30','24.02.2013','20:00','Moorflagen 35, Hamburg' ],
]

playday_list.each do |playday|
  @event = Event.create( category: playday[0], remark: playday[1], base_date: playday[2], base_time: playday[3], end_date: playday[4], place: playday[6] )
  if @event.save
    Recurrence.create(:event_id => @event.id, :scheduled_to => @event.base_date)
  end
end

# 2012-12-29, hb-!
# manual migration for new column 'participation.status':
# - every existing entry in the participation table, represents acceptance
# - so every existing participation.status need to be set to 'true'
#
# $ heroku run rails console
# participations = Participation.find(:all)
# participations.each { |i| i.update_attributes(status: true); i.save }

