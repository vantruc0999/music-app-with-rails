namespace :api do
    namespace :v1 do
        scope :users, module: :users do
            post '/', to: "registrations#create", as: :user_registration
            get '/get-all-users', to: "users#get_all_users"
            get '/get-user', to: "users#get_user"
            post '/update-user', to: "users#update_user"
        end

        resources :genres

        resources :artists

        resources :albums

        resources :songs
    end
end

scope :api do
    scope :v1 do
        use_doorkeeper do
            skip_controllers :authorizations, :applications, :authorized_applications
        end
    end
end