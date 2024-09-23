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
    end
  
    # Nested routes for comments inside courses
    resources :comments
  end
  

  # Batches and their tasks
  resources :batches do
    post 'add_trainee', on: :member
    resources :tasks do
      member do
        patch 'update_status', to: 'tasks#update_status'
      end
    end
    get 'track_tasks', to: 'tasks#track_tasks', as: 'track_tasks'
  end
  

  get 'tasks_assigned', to: 'tasks#index', as: 'tasks_assigned'
  
  get 'my_courses', to: 'courses#my_courses', as: 'my_courses'
  get 'manage_all_trainees', to: 'courses#manage_all_trainees', as: 'manage_all_trainees'
end
