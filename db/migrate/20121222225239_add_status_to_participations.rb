class AddStatusToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :status, :boolean, default: false
  end
end

