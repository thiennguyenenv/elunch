class Table < ActiveRecord::Base
  attr_accessor :shifts
  validates :name, presence: true

  belongs_to :shift
  has_many :seating_charts
  has_many :tables_users
  has_many :users, through: :tables_users
  default_scope { order('id ASC') }

  serialize :cached_seats

  DEFAULT_SEAT = { id: "-1", first_name: "", last_name: "", available: "true", avatar_url: "/avatar/thumb/user.png" }

  def init_seats(number_seats_param)
    seats = number_seats_param.to_i
    SeatingChartCategory.all.each do |category|
      new_seating_chart = SeatingChart.new(number_seats: seats, available_seats: seats, chart_category_id: category.id, description: category.name, table_id: self.id)
      new_seating_chart.seating_chart = Array.new
      index = 1
      while new_seating_chart.number_seats.present? && new_seating_chart.number_seats > 0 && index <= new_seating_chart.number_seats do
        new_seating_chart.seating_chart.push(DEFAULT_SEAT.clone)
        index += 1
      end
      new_seating_chart.save
    end
    return true
  end

  def add_seat(user)
    return false unless user.id.present?
    ActiveRecord::Base.transaction do
      begin
        seating_charts.each do |chart|
          if chart.available_seats > 0
            index = 0
            position = chart.seating_chart.find_index { |seat| seat[:id] == '-1' }
            if position.present?
              chart.available_seats -= 1
              chart.seating_chart[position] = { id: user.id, first_name: user.first_name, last_name: user.last_name, available: :true, avatar_url: user.avatar.url(:thumb) }
              chart.save
            end
          else
            return false
          end
        end
        return true
      rescue
        return false
      end
    end
  end

  def empty_seat(user_id)
    ActiveRecord::Base.transaction do
      begin
        seating_charts.each do |chart|
          position = chart.seating_chart.find_index { |seat| seat[:id] == user_id }
          if position.present?
            chart.available_seats += 1
            chart.seating_chart[position] = DEFAULT_SEAT
            chart.save
          else
            return false
          end
        end
        return true
      rescue
        return false
      end
    end
  end

  def chart(cat_id = 1)
    seating_charts.where(chart_category_id: cat_id).first
  end

  def update_cached_seats(user)
    index = 0
    seating_charts.each do |chart|
      chart.seating_chart.each do |seat|
        if seat[:id].to_i == user.id
          chart.seating_charts[index] = { first_name: user.first_name, last_name: user.last_name, available: :true, avatar_url: user.avatar.url(:thumb) }
          return chart.save
        end
        index += 1
      end
    end
  end

  def shifts
    Shift.all
  end
end
