Rails.application.routes.draw do
  resources :collection_dates, only: :show, param: :collection_area_id

  root 'areas#index'
end
