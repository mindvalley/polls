class Vote
  include Mongoid::Document
  embedded_in :ballot

  field :candidate, type: String
  field :points, type: Float

end
