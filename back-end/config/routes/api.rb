namespace :api do
    namespace :v1 do
        scope :users, module: :users do
            post '/', to: "registrations#create", as: :user_registration
            get '/get-all-users', to: "users#get_all_users"
            get '/get-user', to: "users#get_user"
            post '/update-user', to: "users#update_user"
            post 'password/forgot', to: 'password_resets#forgot'
            post 'password/reset/:token', to: 'password_resets#reset'
        end

        resources :genres

        resources :artists

        resources :albums

        resources :songs

        resources :playlists do 
            collection do
                post '/add-to-playlist/:id', to: "playlists#add_to_playlist"
                delete '/remove-from-playlist/:id', to: "playlists#remove_from_playlist"
            end
        end

        post '/favorites/toggle', to: 'favorites#toggle_favorite'
        get '/favorites/lists', to: 'favorites#get_my_favorites'
    end
end

scope :api do
    scope :v1 do
        use_doorkeeper do
            skip_controllers :authorizations, :applications, :authorized_applications
        end
    end
end