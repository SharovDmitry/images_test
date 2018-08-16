class User
  include Mongoid::Document
  field :auth_token, type: String

  has_many :images

  validates :auth_token, uniqueness: true

  before_create :generate_auth_token!

  protected

  def generate_auth_token!
    self.auth_token = SecureRandom.hex
    generate_auth_token! if User.where(auth_token: self.auth_token).exists?
  end
end
