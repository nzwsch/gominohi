Rails.application.routes.draw do
  resources :collection_dates, only: :show, param: :collection_area_id

  resources :collection_areas, only: :show do
    resources :gomi_types, only: %i[index show]
  end

  root 'areas#index'
end
