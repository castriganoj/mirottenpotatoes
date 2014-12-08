class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.ratings
	 Movie.all.map(&:rating).uniq.sort
    end
end






