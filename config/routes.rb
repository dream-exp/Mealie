Rails.application.routes.draw do

	get '/menus', to: 'menus#index'
  get '/menus/:category', to: 'menus#category'
  get '/menus/:category/:id', to: 'menus#detail'

  get '/mypage/:student_number', to: 'users#index'

  get '/removetray/:id', controller: 'menus', action: 'removetray'

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
