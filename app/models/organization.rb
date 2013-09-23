class Organization
  include Mongoid::Document
  include Mongoid::EmbeddedErrors
  include Mongoid::Timestamps

  field :name, type: String

  embedded_in :user
  embeds_many :templates

  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }
  validates :user, presence: true
end
