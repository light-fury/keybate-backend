class User < ApplicationRecord
  resourcify
  rolify

  # Include default devise modules. Removed :confirmable.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :attendees
  has_many :rooms, through: :attendees
  has_many :moderators
  has_many :favorites
  has_many :favorite_questions
  has_many :questions, through: :favorite_questions
  has_many :qcm_polls, through: :answered_polls
  has_many :event_users
  has_many :events, through: :event_users
  has_many :notifications
  has_many :answers, class_name: 'PollAnswer'
  has_many :questions
  has_many :upvotes, class_name: 'QuestionUpvote'
  has_many :event_moderators
  has_many :moderatored_events, through: :event_moderators, source: :event
  has_many :messages

  before_create :add_default_picture
  before_update :change_default_picture

  def contacts
    Contact.where('from_user_id = :user_id OR to_user_id = :user_id', user_id: self.id)
  end

  def picture_url_thumbnail
    self.picture_url.include?("cloudinary") ? "https://res.cloudinary.com/keybate/image/upload/g_face,c_thumb,w_150,h_150,q_auto:low/#{self.picture_url.split(/\//).last}" : self.picture_url
  end

  def picture_url_full
    self.picture_url.include?("cloudinary") ? "https://res.cloudinary.com/keybate/image/upload/c_scale,w_350,q_auto:eco/#{self.picture_url.split(/\//).last}" : self.picture_url
  end

  # To override default user json data that is returned by devise_token_auth
  def as_json(opts = {})
    return {
      id: self.id,
      email: self.email,
      provider: self.provider,
      uid: self.uid,
      first_name: self.first_name,
      last_name: self.last_name,
      location: self.location,
      position: self.position,
      picture: {
        thumbnail: self.picture_url_thumbnail,
        full: self.picture_url_full
      },
      api_user_id: self.api_user_id,
      facebook_profile_link: self.facebook_profile_link,
      linkedin_profile_link: self.linkedin_profile_link,
      questions_count: self.questions_count,
      upvotes_count: self.upvotes_count,
      description: self.description,
      deleted: self.deleted
    }
  end
  

  private

    def add_default_picture
      if self.picture_url.blank?
        base_url = "https://placeholdit.imgix.net/~text?txtsize=200&w=300&h=300&txttrack=0&txt="

        if self.first_name.present? && self.last_name.present?
          first_initial = self.first_name[0]
          last_initial = self.last_name[0]
          self.picture_url = base_url + first_initial + last_initial
        else
          self.picture_url = base_url + "AU"
        end
      end
    end

    def change_default_picture
      if self.picture_url.include? "placeholdit.imgix"
        changed_first_name = self.first_name_changed?
        changed_last_name = self.last_name_changed?

        if changed_first_name || changed_last_name
          base_url = "https://placeholdit.imgix.net/~text?txtsize=200&w=300&h=300&txttrack=0&txt="

          if self.first_name.present? && self.last_name.present?
            first_initial = self.first_name[0]
            last_initial = self.last_name[0]
            self.picture_url = base_url + first_initial + last_initial
          else
            self.picture_url = base_url + "AU"
          end
        end
      end
    end

end
