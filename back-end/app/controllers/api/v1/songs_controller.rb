class Api::V1::SongsController < ApiController
    before_action :set_song, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create update destroy]

    include ApplicationHelper
    include ApiResponse
    include SongDetailsConcern

    def index
      @songs = render_song_data(Song.includes(:genre, :artists, :album).all)
      render_success(@songs, "Songs loaded successfully")
    end
      
    def show
      render_song_data(@song, "Song loaded successfully")
    end

    def create
        if !params[:artists]
            render_error("Artist must be an array includes artist_id")
            return ;
        end
        @song = Song.new(song_params)
        if @song.save
          params[:artists].each do |artist_id|
            artist = Artist.find_or_create_by(id: artist_id)
            @song.artists << artist
          end
          SongMailer.with(user: current_user, song: @song).song_created.deliver_later
          render_success(@song,  "song created successfully")
        else
          render_error( @song.errors)
        end
    end

    def update
        if !params[:artists]
            render_error("Artist must be an array includes artist_id")
            return ;
        end
        if @song.update(song_params)
        @song.artists.clear    
        params[:artists].each do |artist_id|
            artist = Artist.find_or_create_by(id: artist_id)
            @song.artists << artist
        end
            render_success(@song,  "song updated successfully")
        else
            render_error( @song.errors)
        end
    end

    def destroy
        if @song.destroy
            render_success(@song, 'song deleted successfully')
        else
            render_error('Failed to delete song')
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_song
        @song = Song.find_by(id: params[:id])

        if !@song
            render_error( "Song not found")
        end

      end
  
      # Only allow a list of trusted parameters through.
      def song_params
        params.permit(:name, :duration, :release_year, :lyric, :play_count, :album_id, :genre_id, :artists, :audio, :song_image)
      end
end
