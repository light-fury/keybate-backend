class Contact < ApplicationRecord
  belongs_to :event, counter_cache: :contacts_count
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  has_many :notifications, dependent: :delete_all
  has_many :messages, dependent: :delete_all
end
