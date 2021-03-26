
class SongsController < ApplicationController


    get "/songs" do 
        @songs = Song.all
        erb :"songs/index" 
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new'
    end

    get "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/show"
    end

    post "/songs" do     
        @song = Song.create(params[:song])
        @artist = Artist.find_by(name: params[:artist][:name])
        @genres_params = params[:genres]

            if !@artist
                @new_artist = Artist.create(params[:artist])
                @song.artist = @new_artist
            else
                @song.artist = @artist
            end

            if params[:genres]
                    @genres_params.each do |genre_id|
                    
                        @song.genres << Genre.find_by(id: genre_id)
                    end
            end
        @song.save
        # binding.pry
      
        flash[:message] = "Successfully created song."
       
            redirect "/songs/#{@song.slug}"
    end

    get "/songs/:slug/edit" do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :"/songs/edit"
    end

    patch "/songs/:slug" do 
        @song = Song.find_by_slug(params[:slug])
        # binding.pry
        # if params["song"]["name"]
            @song.update(name: params[:song][:name])
           
        # end
        # if params["artist"]["name"]
        # binding.pry
            @song.artist = Artist.find_or_create_by(name: params[:artist][:name]) 
            @song.save

        # end
        # @song.genre_ids =
        flash[:message] = "Successfully updated song."

        redirect "/songs/#{@song.slug}"
    end
    
end