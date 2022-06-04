Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'words#home'
  get '/:word', to: 'words#query', as: 'query'

  get '*unmatched_route', to: 'words#redirect'
end
