class Track
  include Mongoid::Document

  field :name, type: String
  field :color, type: String, default: ''
  field :diagram, type: String, default: ''
  field :locked, type: Boolean, default: false
  field :order, type: Integer

  has_many :flags

  validates_presence_of :name
  validates_presence_of :order
end
