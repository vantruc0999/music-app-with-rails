class Api::V1::FavoritesController < ApiController
    include ApplicationHelper
    include ApiResponse
    include SongDetailsConcern

    def get_my_favorites
        @favorite_songs = current_user.songs
        user_data = current_user
        song = render_song_data(@favorite_songs, "Songs loaded successfully")

        response_data = {
            user: user_data,
            favorite_songs: song
        }

        render_success(response_data, 'Songs loaded successfully')
    end
    
    def toggle_favorite
        song = Song.find(params[:song_id])
        favorite = current_user.favorites.find_by(song: song)
  
        if favorite
          favorite.destroy
          render_success(favorite, "Song '#{song.name}' removed from favorites")
        else
          favorite = current_user.favorites.build(song: song)
          if favorite.save
            render_success(favorite, "Song '#{song.name}' add to favorites")
          else
            render_error("Error adding the song to favorites")
          end
        end
    end

end
