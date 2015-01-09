Rails.application.routes.draw do

  root to: "documents#index"

  resources :documents do
    put 'undo', on: :member
  end
end
