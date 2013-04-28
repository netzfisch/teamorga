class Group < ActiveRecord::Base
  attr_accessible :logo_url, :name, :private_information, :public_information
end
