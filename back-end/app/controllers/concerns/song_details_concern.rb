# app/controllers/concerns/song_details_concern.rb

module SongDetailsConcern
    extend ActiveSupport::Concern
  
    included do
      def render_song_data(song)
        data = song.as_json(
          include: {
            genre: {
              except: [:created_at, :updated_at],
            },
            album: {
              except: [:created_at, :updated_at],
              methods: :cover_url
            },
            artists: {
              except: [:created_at, :updated_at],
              methods: :artist_image_url
            },
          },
          except: [:album_id, :genre_id],
          methods: [:image_url, :audio_url]
        )
    
        return data
      end
    end
  end
  