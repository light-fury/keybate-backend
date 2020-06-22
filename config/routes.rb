Rails.application.routes.draw do
  concern :api_base do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks:  'overrides/omniauth_callbacks'
    }
    mount ActionCable.server => '/cable'
    resource :profile, only: [:show, :update]
    get 'contacts/discussions', to: 'contacts#with_messages'
    put 'password_reset', to: 'users#password_reset'
    resources :contacts, except: [:new, :edit] do
      resources :messages, except: [:new, :edit] do
        patch 'mark_as_read', on: :member
      end
      member do
        patch 'block'
        patch 'unblock'
      end
    end
    resources :notifications, only: [:index, :show, :destroy] do
      patch 'mark_as_read', on: :member
    end
    resources :events, only: [:index, :show] do
      resources :attendees, only: :index
      resources :rooms, only: [:index, :show] do
        resources :attendees, only: :index
        resources :polls, only: [:index, :show] do
          resources :answers, except: [:new, :edit]
        end
        resources :questions, except: [:new, :edit] do
          resources :upvotes, only: [:create, :destroy]
        end
      end
    end
    post 'events/:code/join', to: 'events#join'
    post 'events/:event_id/rooms/:id/join', to: 'rooms#join'
    post 'upload_photo', to: 'cloudinary_upload#upload'
    namespace :admin do
      resources :events, only: [:index, :show, :create, :update, :destroy] do
        resources :rooms, only: [:create, :show, :update, :destroy] do
          member do
            patch 'clear_display'
            patch 'hide_questions'
            patch 'show_questions'
            patch 'allow_microphone_requests'
          end
          resources :attendees, only: :index
          patch 'polls/reorder', to: 'polls#reorder'
          resources :polls, except: [:new, :edit] do
            member do
              patch 'publish'
              patch 'open'
              patch 'display_results'
              patch 'destroy_option'
            end
          end
          resources :questions, only: :index do
            member do
              patch 'hide'
              patch 'display'
              patch 'pin'
              patch 'send_to_bottom'
              patch 'allow'
              patch 'remove'
              post 'call'
              post 'hangup'
            end
          end
        end
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      concerns :api_base
    end
  end
end
