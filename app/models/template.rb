class Template
  include Mongoid::Document
  include Mongoid::EmbeddedErrors
  include Mongoid::Timestamps

  field :body_html, type: String
  field :body_text, type: String
  field :from,      type: String
  field :name,      type: String
  field :subject,   type: String

  embedded_in :organization
  embeds_many :variables

  validates :body_html, presence: true
  validates :body_text, presence: true
  validates :from,      presence: true, format: { with: /\A[a-zA-Z0-9\._\+-]+@[a-zA-Z0-9_-]+\.[a-zA-Z0-9\.]+\Z/ }
  validates :name,      presence: true
  validates :subject,   presence: true
  validates_uniqueness_of :name, scope: [:organization]
  validate  :valid_from_address?

private

  def valid_from_address?
    true # TODO: check `from` field to match oragnization domain
  end
end
