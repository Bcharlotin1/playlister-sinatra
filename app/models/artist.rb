class Artist < ActiveRecord::Base
    # add relationships here
    has_many :songs
    has_many :genres,  through:  :songs
  end