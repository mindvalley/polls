class Ballot
  include Mongoid::Document
  embeds_many :votes
  accepts_nested_attributes_for :votes, update_only: true

  belongs_to :voter, class_name: 'User'
  field :period, type: String
  field :adjustment_factor, type: Float, default: 1.00

  default_scope order_by('voter.email_address' => :asc)

  def self.compute_results(period)
    result = {}
    result.default = 0.0
    where(period: period).each do |ballot|
      af = ballot.adjustment_factor
      ballot.votes.each do |vote|
        next if vote.nil?
        result[Employee.find(vote.candidate).email_address] += vote.points.to_f * af
      end
    end
    (result.sort_by {|k,v| v}).reverse
  end
end
