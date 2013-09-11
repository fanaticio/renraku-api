class Organization
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  embedded_in :user

  validates :name, presence: true, uniqueness: true
  validates :user, presence: true
end
