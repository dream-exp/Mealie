Rails.application.routes.draw do


  get 'control/administration'

  get '/logins', to: 'logins#index'
  get '/logins/:student_number', to: 'logins#update_user'

	get '/menus', to: 'menus#index'
  get '/menus/reset', to: 'menus#reset'
  get '/menus/new', to: 'menus#new'
  get '/menus/destroy/:id', to: 'menus#destroy'
  get '/menus/management', to: 'menus#management'
  get '/menus/edit/:id', to: 'menus#edit'
  post '/menus/create', to: 'menus#create'
  get '/menus/:category', to: 'menus#category'
  get '/menus/:category/:id', to: 'menus#detail'

  resources :menus

  get '/mypage/:student_number', to: 'users#index'
  get '/tray/:student_number', to: 'users#tray'
  get '/past_order/:student_number', to: 'users#past_order'

  get '/orders/new/:id', to: 'orders#new'
  get '/orders/confirm/:student_number', to: 'orders#confirm'
  get '/orders/paid/:student_number', to: 'orders#paid'
  get '/orders/destroy/:id/:from', to: 'orders#destroy'
  get '/orders/destroyall/:student_number', to: 'orders#destroyall'

  get '/payments', to: 'payments#index'
  get '/payments/:student_number', to: 'payments#payments_user_update'
  get '/payments/confirmation/:student_number', to: 'payments#confirmation'
  get '/payments/pay/:student_number', to: 'payments#pay'

  get '/administration', to: 'administration#index'
  get '/administration/penalty', to: 'administration#penalty'
  get '/administration/statistics', to: 'administration#statistics'
  get '/administration/:student_number', to: 'administration#index'


  # resources :menus do
  # 	member do
  # 		get 'detail'
  # 	end

  #   collection do
  #     get 'index'
  #   end 
  # end
end
