Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :characters do
    end
  
    resources :episodes do
    end
  
    resources :locations do
    end
  end
end
