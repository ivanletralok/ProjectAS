Rails.application.routes.draw do
  root 'inicio#index'
  resources :comentarios
  resources :pqrs
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
  resources :dependencia
  resources :rols
  resources :tipodocumentos
  get 'registro', to: 'usuarios#new', as: 'registro'
  get 'iniciarSesion', to: 'sessions#new', as: 'iniciarSesion'
  get 'cerrarSesion', to: 'sessions#destroy', as: 'cerrarSesion'
  get 'coment', to: 'pqrs#coment'
  post 'prueba', to: 'pqrs#prueba'
  post 'prueba_comentario', to: 'pqrs#prueba_comentario'
  post 'prueba', to: 'comentarios#prueba'
  post 'prueba_comentario', to: 'comentarios#prueba_comentario'
  post 'respuesta', to: 'pqrs#respuesta'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
