class Result
  include Mongoid::Document
  field :period, type: String
  field :lines, type: Array
end
