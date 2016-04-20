Rails.application.routes.draw do
  resources :logins do
    get 'index'
  end

  resources :menus do
    collection do
      get 'index'
    end 
  end
end
