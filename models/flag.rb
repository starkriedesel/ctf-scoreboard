class Flag
  include Mongoid::Document

  field :points, type: Integer
  field :locked, type: Boolean, default: false
  field :value, type: String
  field :order, type: Integer
  field :name, type: String, default: ->{points.to_s}
  field :view, type: String, default: ->{"flag_#{track.name.downcase}_#{name.downcase}"}
  field :hide, type: Boolean, default: false

  belongs_to :track
  has_and_belongs_to_many :users

  validates_presence_of :value, :points, :order, :name
  validates_uniqueness_of :value
end
