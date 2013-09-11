class User
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save       :encrypt_password, if: ->(model) { model.password_changed? }
  before_validation :generate_token,   if: ->(model) { model.auth_token.nil? }

  field :auth_token, type: String
  field :email,      type: String
  field :login,      type: String
  field :password,   type: String

  embeds_many :organizations

  validates :auth_token, presence: true, uniqueness: true
  validates :email,      presence: true, uniqueness: true
  validates :login,      presence: true, uniqueness: true
  validates :password,   length: { minimum: 8 }, presence: true

private

  def generate_token
    self.auth_token = Container.get('token.generator').generate
    generate_token if User.where(auth_token: self.auth_token).exists?
  end

  def encrypt_password
    self.password = Container.get('password.encryption').encrypt(self.password)
  end
end
