RailsBoilerplate::Application.routes.draw do
  get "widget/hurry_up_jose"

  get "welcome/index"

  get "welcome/prueba_widget"


  root :to => 'welcome#index'

  get "api/rios/alturas_por_ciudad"
  get "api/rios/index"
  get "api/rios/rio"
  get "api/rios/puerto"
end
