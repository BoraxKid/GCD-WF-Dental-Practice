Rails.application.routes.draw do

  namespace :admin do
    resources :dentists
  end

  namespace :admin do
    resources :appointments
  end

  namespace :admin do
    resources :patients
  end

  namespace :admin do
    resources :contacts
  end

  get '/contact', to: 'contacts#new'
  post '/contact', to: 'contacts#create'
  comfy_route :blog_admin, path: "/admin"
  comfy_route :blog, path: "/blog"
  # devise_for :staffs
  # devise_for :admins
  # root 'welcome#index'

  comfy_route :cms_admin, path: "/admin"
  # Ensure that this route is defined last
  comfy_route :cms, path: "/"

end
