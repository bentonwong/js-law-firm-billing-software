class Lawyer < ApplicationRecord
  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries
  validates :name, :email, :rate, presence: :true
  validates :email, uniqueness: :true
  validates :rate, numericality: { greater_than_or_equal_to: 0 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  validates :password, length: { minimum: 8 }, allow_nil: true
  has_secure_password

  def self.current_rate(lawyer_id)
    find_by(id: lawyer_id).rate
  end

  def self.update_or_create(auth)
    lawyer = Lawyer.find_by(email: auth[:info][:email]) || Lawyer.new
    lawyer.attributes = {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      name: auth[:info][:name],
      oauth_token: auth[:credentials][:token],
      oauth_expires_at: auth[:credentials][:expires_at]
    }
    lawyer.password = SecureRandom.hex(9) if !lawyer.password_digest
    lawyer.save!
    lawyer
  end

end
