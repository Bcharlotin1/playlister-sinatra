class Song < ActiveRecord::Base
    # add relationships here
    belongs_to :artist
    has_many :song_genres
    has_many :genre, through: :song_genres

    def slug
      name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug) 
       Song.all.find {|genre| genre.slug == slug}  
    end
  end