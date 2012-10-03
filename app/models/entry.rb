class Entry
  include Mongoid::Document
  field :name, type: String

  def self.valid
    self.all
  end
end
