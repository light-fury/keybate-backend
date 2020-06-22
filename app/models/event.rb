class Event < ApplicationRecord
  resourcify

  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  has_many :rooms, class_name: 'Room'
  has_many :event_moderators, dependent: :destroy
  has_many :contacts
  has_many :questions
  has_many :polls
  has_many :moderators, through: :event_moderators, source: :user
  has_many :agendas, class_name: 'EventAgenda', dependent: :destroy
  has_many :speakers, class_name: 'EventSpeaker', dependent: :destroy
  has_many :sponsors, class_name: 'EventSponsor', dependent: :destroy
  has_many :notifications

  accepts_nested_attributes_for :agendas, :speakers, :sponsors, :rooms, allow_destroy: true

  before_create :generate_code

  validates :name, presence: true
  validates :code, uniqueness: true
  validates :plan, inclusion: { in: %w(pro premium) }

  def generate_code
    self.code = loop do
      random_code = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
      break random_code unless self.class.exists?(code: random_code)
    end
  end

  def upvotes_count
    total = 0
    self.questions.each do |question|
      total += question.upvotes_count
    end
    return total
  end

  def poll_answers_count
    total = 0
    self.polls.each do |poll|
      total += poll.answers_count
    end
    return total
  end

  def cover_photo_web
    if self.cover != nil
      self.cover.include?("cloudinary") ? "https://res.cloudinary.com/keybate/image/upload/q_auto:good/#{self.cover.split(/\//).last}" : self.cover
    else
      nil
    end
  end

  def cover_photo_mobile
    if self.cover != nil
      self.cover.include?("cloudinary") ? "https://res.cloudinary.com/keybate/image/upload/c_scale,w_600,q_auto:eco/#{self.cover.split(/\//).last}" : self.cover
    else
      nil
    end
  end
end
