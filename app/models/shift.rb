class Shift < ActiveRecord::Base
  validates :name, :start_time, :end_time, presence: true
  validate :start_time_can_not_be_greater_than_end_time

  private
  def start_time_can_not_be_greater_than_end_time
    return if start_time.nil? || end_time.nil?
    if start_time > end_time
      errors.add(:start_time, "can't be greater than end date")
    end
  end    
end
