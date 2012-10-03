class Employee
  include Mongoid::Document

  scope :votable, where(votable: true)

  default_scope order_by(status: :asc, email_address: :asc)

  field :email_address, type: String
  validates :email_address, uniqueness: true

  field :date_joined, type: Date
  field :start_date_dd_mm_yy, type: String
  field :votable, type: Boolean, default: true
  field :team, type: String, default: ->{ team.nil? ? '' : team.downcase }
  field :status, type: String
  field :nick_name, type: String

  belongs_to :user

  def update_date_joined
    self.date_joined = Date.parse(self.start_date_dd_mm_yy)
    self.save!
  end

end
