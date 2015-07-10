class TablesUser < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
end