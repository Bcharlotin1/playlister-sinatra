class SongsController < ApplicationController
    get "/songs" do 
        @songs = Song.all
        erb :"songs/index" 
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new'
    end

    post "/songs" do 
        # binding.pry
        # @song = Song.create(params[:song])
        # @artist = Artist.find_by(name: params[:artist][:name])
    
        # if @artist
            
        #     @song.artist = artist
        # else
        #     @song.create_artist(params[:artist])
        #     @new_artist = Artist.create(params[:artist])
        # end
        
        @song = Song.create(params[:song])
        @artist = Artist.create(params[:artist])
        @genres_params = params[:genres]

        @genres_params.each do |genre_id|
           
            @song.genres << Genre.find_by(id: genre_id)
        end
        @song.artist = @artist
# binding.pry
       
        redirect :"songs/:slug"
        
        
    
    end

    get "/songs/:slug" do
    
        @song = Song.find_by_slug(params[:slug])
        
        erb :"/songs/show"
    end
end