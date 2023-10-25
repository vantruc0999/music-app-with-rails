class Api::V1::AlbumsController < ApiController
    before_action :set_album, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create update destroy]

    include ApplicationHelper
    include ApiResponse

    def index
        @albums = Album.includes(:artist).all
        data = @albums.as_json(
          include: {
            artist: {
              except: [:created_at, :updated_at],
              methods: :artist_image_url
            }
          },
          methods: :cover_url
        )
        render_success(data, 'Albums loaded successfully')
      end

    def show    
        cover_url = @album.cover_url if @album.cover.attached?
        data = @album.as_json(
          include: { artist: { except: [:created_at, :updated_at], methods: :artist_image_url }
        })
        data['cover_url'] = cover_url
        render_success(data, 'Album loaded successfully')
    end

    def create
        @album = Album.new(album_params)

        if @album.save
            render_success(@album, "album created successfully")
        else
            render_error(@album.errors)
        end
    end

    def update
        if @album.update(album_params)
            render_success(@album, "album updated successfully")
          else    
            render_error(@album.errors)
        end
    end

    def destroy
        @album.destroy
        render_success(@album, "album deleted successfully")
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_album
        @album = Album.find_by(id: params[:id])

        if !@album
            render_error( "album not found")
        end
      end
  
      # Only allow a list of trusted parameters through.
      def album_params
        params.permit(:name, :artist_id, :cover)
      end
end
