class Api::V1::GenresController < ApiController
    before_action :set_genre, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create update destroy]

    include ApplicationHelper
    include ApiResponse

    def index
        @genres = Genre.all
        render_success(@genres, 'Genres loaded successfully')
    end 

    def show
        render_success(@genre, "Genres loaded successfully")
    end

    def create
        @genre = Genre.new(genre_params)

        if @genre.save
          render_success(@genre, "Genres created successfully")
        else    
          render_error(@genre.errors)
        end
    end

    def update
        @genre = Genre.new(genre_params)

        if @genre.save
          render_success(@genre, "Genres created successfully")
        else    
          render_error(@genre.errors)
        end
    end

    def destroy
        @genre.destroy
        render_success(@genre, "Genres deleted successfully")
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_genre
        @genre = Genre.find_by(id: params[:id])

        if !@genre
            render_error( "Genre not found")
        end

      end
  
      # Only allow a list of trusted parameters through.
      def genre_params
        params.permit(:name)
      end
end
