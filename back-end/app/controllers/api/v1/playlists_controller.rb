class Api::V1::PlaylistsController < ApiController
    before_action :set_playlist, only: %i[show update destroy add_to_playlist remove_from_playlist] 
    before_action :set_song, only: %i[add_to_playlist remove_from_playlist] 
    # skip_before_action :doorkeeper_authorize!, only: %i[index show] 
    before_action :authorize_user, only: %i[update destroy add_to_playlist remove_from_playlist] 

    include ApiResponse
    include ApplicationHelper
    include SongDetailsConcern
    
    def index
        @playlists = current_user.playlists
        render_success(@playlists, 'Playlists load successfully')
    end

    def show
        data = @playlist.as_json
        data['songs'] = render_song_data(@playlist.songs)
        render_success(data, 'Playlist load successfully')
    end

    def create
        @playlist = current_user.playlists.build(playlist_params)

        if @playlist.save
            render_success(@playlist, 'Playlist created successfully')
        else
            render_error(@playlist.errors)
        end
    end

    def update
        if @playlist.update(playlist_params)
            render_success(@playlist, 'Playlist updated successfully')
        else
            render_error(@playlist.errors)
        end   
    end

    def destroy
        if @playlist.destroy
            render_success(@playlist, 'Playlist deleted successfully')
        else
            render_error('Failed to delete playlist')
        end
    end

    def add_to_playlist
        if @playlist.songs.include?(@song)
            render json: { error: 'Song is already in the playlist' }, status: :unprocessable_entity
            return
        end

        if @playlist.songs << @song
            render_success(@playlist, 'Song added to the playlist')
        else
            render_error('Failed to add the song to the playlist')
        end
    end

    def remove_from_playlist
        unless @playlist.songs.include?(@song)
            render json: { error: 'Song is not in the playlist' }, status: :unprocessable_entity
            return
        end
    
        # Remove the song from the playlist
        if @playlist.songs.destroy(@song)
            render_success(@playlist, 'Song removed from the playlist')
        else
            render_error('Failed to remove the song from the playlist')
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_playlist
        @playlist = Playlist.find_by(id: params[:id])

        if !@playlist
            render_error( "Playlist not found")
        end
      end

      def set_song
        @song = Song.find_by(id: params[:song_id])

        if !@song
            render_error( "Song not found")
        end
      end
  
      # Only allow a list of trusted parameters through.
      def playlist_params
        params.permit(:name, :song_id)
      end 

      def authorize_user
        return if @playlist.user == current_user
  
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end
end
