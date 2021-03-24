class Genre < ActiveRecord::Base
    # add relationships here
    has_many :artists, through: :songs
    has_many :song_genres
    has_many :songs, through: :song_genres
  end