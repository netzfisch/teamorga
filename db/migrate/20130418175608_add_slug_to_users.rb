class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true 

    User.find_each(&:save)
    # 2013-04-18-hb! - alternatively MANUAL migration for new column 'user.slug':
    # - for every existing entry in the user table, we need to generate a slug and
    # - that way it will be automaticly filled by 'friendly_id' method
    #
    # $ heroku run rails console
    # User.find_each(&:save)
  end
end
