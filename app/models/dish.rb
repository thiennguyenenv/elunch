class Dish < ActiveRecord::Base
  attr_accessor :categories
  has_many :pictures, :dependent => :destroy

  def categories
    Category.all
  end
end
