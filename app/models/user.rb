class User < ApplicationRecord

  has_many  :events, dependent: :destroy
  has_and_belongs_to_many  :attended_events,
                           class_name:  "Event",
                           foreign_key: "event_id",
                           association_foreign_key: 'user_id'

  has_secure_password
  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
                   length: {maximum: 30, minimum: 2},
                   uniqueness:{ case_sensitive: false }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness:{ case_sensitive: false }

  def upcoming_events
    self.attended_events.where("date >= :current_date",
                              current_date: DateTime.now)
  end

  def past_events
    self.attended_events.where("date < :current_date",
                              current_date: DateTime.now)
  end


  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActivateModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(String, cost: cost)
  end

  private

  def downcase_email
    email.downcase!
  end



end
