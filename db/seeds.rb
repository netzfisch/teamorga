# encoding: utf-8
#
# This file contains records needed to seed the PRODUCTION database with default
# values, as well as demo data for the DEVELOPMENT environment.
#
# To clear and seed the database do something like this
#
# $ rake db:drop
# $ rake db:migrate
# $ rake db:seed
#
# or as one-liner '$ rake db:drop db:migrate db:seed', which is much faster!
#
# Alternatively get some data for the development environment from your running live
# database, e.g. require the 'taps' gem to retrieve and dump test data from heroku:
#
# $ heroku db:pull

matchdata = [
  [ 'SCN/AlTSV/GWE','Pellwormstrasse 35, Norderstedt' ],
  [ 'AlTSV/NTSV/Halst','Thadenstrasse 147' ],
  [ 'Halst/NTSV/AlTSV','Feldstrasse 26, Halstenbek' ],
  [ 'Blank/AlTSV/NTSV','Karstenstr. 22, Hamburg' ],
  [ 'AlTSV/AFC/SCN','Thadenstrasse 147, Hamburg' ],
  [ 'FSVH/NTSV/AlTSV','Baererstrasse 45, Harburg' ],
  [ 'AlTSV/Blank/GWE','Thadenstrasse 147 Hamburg' ],
  [ 'AlTSV/VGE/FSVH','Thadenstrasse 147, Hamburg' ],
  [ 'VGE/AlTSV/Halst','Astrid-Lindgren-Schule, Koellner Chaussee 10b, Elmshorn' ],
  [ 'NTSV/AlTSV/AFC','Moorflagen 35, Hamburg' ]
]

case Rails.env
when "development"
  # create necessary basic group data
  if Group.all.empty?
    Group.create do |group|
      group.name = "ATSV 1. Herren"
      group.private_information = "Hier können terminübergreifende Informationen stehen, wie **Tabellen Links** und ähnliches!"
    end
  end

  if User.all.empty?
    # create an admin user
    User.create do |user|
      user.name = "admin"
      user.email = "admin@teamorga.com"
      user.password = "admin"
      user.password_confirmation = "admin"
      user.phone = "+49 150 123 45 67"
      user.admin = true
    end

    # create ordinary users
    %w(Fritz Hans Peter George Julien Tim Klaus).each_with_index do |name, index|
      i = index + 1
      User.create do |user|
        user.name = name
        user.email = "#{name}@teamorga.com"
        user.password = "foobar"
        user.password_confirmation = "foobar"
        user.birthday = Date.today + i.weeks - (30 + i).years
        user.phone = "+49 150 123 45 67"
      end
    end
  end

  if Event.all.empty?
    # create a recurring event series of workouts
    workout = Event.create do |event|
      event.category = "Training"
      event.remark = "15 Min frueher wg. Aufwaermen"
      event.base_date = Date.today
      event.base_time = "20:00"
      event.end_date = Date.today.advance(months: 3)
      event.place = "Thedenstr., Hamburg"
    end
    workout.create_recurrences

    # create single events with different matchdata
    matchdata.each_with_index do |data, index|
      counter = index + 2
      matchday = Event.create do |event|
        event.category = "#{counter}. Spieltag"
        event.remark = data[0]
        event.base_date = Date.today.advance(weeks: counter)
        event.base_time = '14:30'
        event.end_date = Date.today.advance(weeks: counter)
        event.place = data[1]
      end
      matchday.create_recurrences
    end
  end

  # create some participations
  if Participation.all.empty?
    Participation.create(recurrence: Recurrence.first, user: User.find(2), status: true)
    Participation.create(recurrence: Recurrence.first, user: User.find(3), status: true)
    Participation.create(recurrence: Recurrence.first, user: User.find(4), status: false)
    Participation.create(recurrence: Recurrence.first, user: User.find(5), status: true)
    Participation.create(recurrence: Recurrence.first, user: User.find(6), status: true)
  end

  # create some comments
  if Comment.all.empty?
    Comment.create(recurrence_id: Recurrence.first.id, user_id: User.first.id, body: "Ich werde etwas später kommen.")
    Comment.create(recurrence_id: Recurrence.first.id, user_id: User.find(3).id, body: "Wer bringt die **Spielerpässe** mit?")
    Comment.create(recurrence_id: Recurrence.find(2).id, user_id: User.find(4).id, body: "Heute geht es gegen den Tabellenführer, yeah!")
  end
when "production"
  # create necessary basic group data
  if Group.all.empty?
    Group.create(name: "DEMO-Group",
      private_information: "Change group name according to your needs,
                           and place here information, which are relevant
                           accross multiple appointments!")
  end
  # make sure to set manually the admin flag to the 'wished' user
  # $ heroku run rails console
  # u = User.where(name: 'Fritz').first
  # u.update_attributes(admin: true)
  # u.save
end
