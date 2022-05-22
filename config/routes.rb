Rails.application.routes.draw do
  resources :collection_areas, only: :show do
    resource :collection_dates, only: %i[show] do
      get 'calendar', on: :member
    end

    resources :gomi_types, only: %i[index show]
  end

  root 'areas#index'
end
