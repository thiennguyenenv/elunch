class Table < ActiveRecord::Base
  attr_accessor :shifts

  serialize :cached_seats
end
