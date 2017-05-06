class Lawyer < ApplicationRecord
  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries
  validates :name, :email, :rate, presence: :true
  validates :email, uniqueness: :true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  validates :password, length: { minimum: 8 }, allow_nil: true
  has_secure_password

  def self.from_omniauth(auth)
    where(provider: auth.provider, lawyer_id: auth.lawyer_id).first_or_initialize.tap do |lawyer|
      lawyer.provider = auth.provider
      lawyer.lawyer_id = auth.lawyer_id
      lawyer.name = auth.info.name
      lawyer.oauth_token = auth.credentials.token
      lawyer.oauth_expires_at = Time.at(auth.credentials.expires_at)
      lawyer.save!
    end
  end

  def self.current_rate(lawyer_id)
    find_by(id: lawyer_id).rate
  end

end
