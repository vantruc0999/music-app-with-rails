class Api::V1::ArtistsController < ApiController
    before_action :set_artist, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create update destroy]

    include ApplicationHelper
    include ApiResponse

    def index
        @artists = Artist.all
        render_success(@artists, 'Artists loaded successfully')
    end

    def show
        data = @artist.as_json
        artist_image_url = @artist.artist_image_url if @artist.artist_image.attached?
        data['artist_image'] = artist_image_url
        render_success(data, 'Artist loaded successfully')
    end

    def create
        @artist = Artist.new(artist_params)

        if @artist.save
            render_success(@artist, "Artist created successfully")
        else
            render_error(@artist.errors)
        end
    end

    def update
        if @artist.update(artist_params)
            render_success(@artist, "Artist updated successfully")
          else    
            render_error(@artist.errors)
        end
    end

    def destroy
        @artist.destroy
        render_success(@artist, "Artist deleted successfully")
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_artist
        @artist = Artist.find_by(id: params[:id])

        if !@artist
            render_error( "Artist not found")
        end
      end
  
      # Only allow a list of trusted parameters through.
      def artist_params
        params.permit(:name, :information, :artist_image)
      end
end
