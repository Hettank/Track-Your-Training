Rails.application.routes.draw do
  resources :enrollments, only: [:index] # Add actions as needed
  root "pages#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  # Routes for Courses
  resources :courses do
    member do
      post 'enroll'
      get 'manage_trainees'
    end
  end

  # Custom route to show courses created by the current trainer
  get 'my_courses', to: 'courses#my_courses', as: 'my_courses'

  # New route to manage all trainees across all courses for the current trainer
  get 'manage_all_trainees', to: 'courses#manage_all_trainees', as: 'manage_all_trainees'
end
