class Variable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,          type: String
  field :default_value, type: String

  embedded_in :template

  validates :name, presence: true
  validates_uniqueness_of :name, scope: [:template]
end
