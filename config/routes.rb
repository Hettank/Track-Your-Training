Rails.application.routes.draw do
  resources :enrollments, only: [:index]

  root "pages#home"

  get 'profile', to: 'pages#profile'
  get 'manage_trainers', to: 'pages#manage_trainers'
  get 'manage_trainees', to: 'pages#manage_trainees'
  get 'manage_courses', to: 'pages#manage_courses'
  delete 'destroy_trainer/:trainer_id', to: 'pages#destroy_trainer', as: 'destroy_trainer'
  delete 'destroy_trainee/:trainee_id', to: 'pages#destroy_trainee', as: 'destroy_trainee'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :courses do
    member do
      post 'enroll'
      delete 'unenroll'
      delete 'remove_trainee/:trainee_id', to: 'courses#remove_trainee', as: 'remove_trainee'
      delete 'destroy', to: 'courses#destroy', as: 'destroy'
    end

    # Nested routes for comments inside courses
    resources :comments
  end

  # resources for tasks
  # resources :tasks

  # resources :batches
  resources :batches do
    post 'add_trainee', on: :member
    resources :tasks, only: [:new, :create, :index, :show]
  end
  
  
  get 'my_courses', to: 'courses#my_courses', as: 'my_courses'
  get 'manage_all_trainees', to: 'courses#manage_all_trainees', as: 'manage_all_trainees'
end
