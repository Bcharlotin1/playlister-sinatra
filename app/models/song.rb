class Song < ActiveRecord::Base
    # add relationships here
    belongs_to :artist
    has_many :song_genres
    has_many :genre, through: :song_genres
  end