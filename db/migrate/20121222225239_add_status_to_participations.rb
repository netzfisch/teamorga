class AddStatusToParticipations < ActiveRecord::Migration
  def self.up
    add_column :participations, :status, :boolean, default: false

    Participation.update_all(status: true)
    # 2012-12-29-hb! - alternatively MANUAL migration for new column 'participation.status':
    # - every existing entry in the participation table, represents acceptance
    # - so every existing participation.status need to be set to 'true'
    #
    # $ heroku run rails console
    # participations = Participation.find(:all)
    # participations.each { |p| p.update_attributes(status: true); p.save }
    #
    # shorter:
    # $ heroku run rails console
    # Participation.find.each { |p| p.update_attribute(status: true); p.save }
  end

  def self.down
    remove_column :participations, :status
  end
end

