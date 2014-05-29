class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.get_ratings
    return ['G','PG','R','PG-13']
  end
end
