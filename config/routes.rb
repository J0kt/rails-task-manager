# This line starts the block for defining routes within a Rails application.
# `Rails.application.routes` refers to the routing engine of your Rails application,
# and `.draw do ... end` is the method used to define all the routes.
Rails.application.routes.draw do

  # This line defines a route for the Rails health check.
  # It specifies that a GET request to the path "/up" will be handled by the "show" action
  # of the "rails/health" controller.
  # `as: :rails_health_check` gives this route a named helper (rails_health_check_path and rails_health_check_url)
  # which can be used to generate the URL for this route.
  get "up" => "rails/health#show", as: :rails_health_check

  # This line defines the root route of your application.
  # When a user navigates to the base URL (e.g., http://localhost:3000/),
  # it will be directed to the "index" action of the "tasks" controller.
  root "tasks#index"

  # This line is a powerful Rails routing helper that generates a full set of RESTful routes
  # for the 'tasks' resource (index, show, new, create, edit, update, destroy).
  # These routes map common HTTP verbs (GET, POST, PATCH, DELETE) to corresponding controller actions.
  resources :tasks do
    # This block defines additional routes that apply to a *specific member* (instance) of the 'tasks' resource.
    member do
      # This line defines a custom route that handles a PATCH request.
      # When a PATCH request is made to a path like `/tasks/:id/toggle_completed`,
      # it will be routed to the `toggle_completed` action within the `tasks` controller.
      # The `patch` HTTP verb is semantically appropriate for changing a partial state (like a boolean flag).
      patch :toggle_completed
    end
  end
