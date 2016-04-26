Rails.application.routes.draw do

	get '/menus', to: 'menus#index'
  get '/menus/:id', to: 'menus#detail'

  resources :logins do
    get 'index'
  end

  # resources :menus do
  # 	member do
  # 		get 'detail'
  # 	end

  #   collection do
  #     get 'index'
  #   end 
  # end
end
