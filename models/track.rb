class Track
  include Mongoid::Document

  field :name, type: String
  field :color, type: String, default: ''
  field :diagram, type: String, default: ''
  field :view, type: String, default: ->{"track_#{name.downcase}"}
  field :locked, type: Boolean, default: false
  field :order, type: Integer

  has_many :flags

  validates_presence_of :name, :order

  def visible_flags(user)
    self.flags.order_by(order: :asc).all.to_a.select do |f|
      (! f.hide) || user.flags.include?(f)
    end
  end
end
