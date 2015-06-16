class Table < ActiveRecord::Base
  attr_accessor :shifts

  has_and_belongs_to_many :users
  default_scope { order('id ASC') }

  serialize :cached_seats

  DEFAULT_SEAT = { id: "-1", first_name: "", last_name: "", available: "true", avatar_url: "/avatar/thumb/user.png" }

  def init_seats
    self.available_seats = self.seats
    self.cached_seats = Array.new
    index = 1
    while index <= self.seats do
      self.cached_seats.push(DEFAULT_SEAT.clone)
      index += 1
    end
    return true
  end

  def add_seat(user)
    return false unless user.id.present?
    if available_seats > 0
      index = 0
      self.cached_seats.each do |seat|
        if seat[:id] == "-1"
          self.available_seats -= 1
          self.cached_seats[index] = { id: user.id, first_name: user.first_name, last_name: user.last_name, available: :true, avatar_url: user.avatar.url(:thumb) }
          return self.save
        end
        index += 1
      end
    end
    return false
  end

  def empty_seat(user_id)
    index = 0
    self.cached_seats.each do |seat|
      if seat[:id] == user_id
        self.available_seats += 1
        self.cached_seats[index] = DEFAULT_SEAT
        return self.save
      end
      index += 1
    end
    return false
  end

  def update_cached_seats(user)
    index = 0
    self.cached_seats.each do |seat|
      if seat[:id].to_i == user.id
        self.cached_seats[index] = { first_name: user.first_name, last_name: user.last_name, available: :true, avatar_url: user.avatar.url(:thumb) }
        return self.save
      end
      index += 1
    end
  end
end
