
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
        binding.pry
        if params["song"]["name"]
            @song.update(:song)
        end
        if params["artist"]["name"]
            @song.update(:artist)
        end
        @song.update(:genres)

        redirect "/songs/#{@song.slug}"
    end
    
end