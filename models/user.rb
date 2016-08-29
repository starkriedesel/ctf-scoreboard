class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :score, type: Integer, default: 0

  has_and_belongs_to_many :flags

  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email, :password, :score

  def update_score
    self.score = flags.to_a.map(&:points).inject(&:+)
    save
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user.nil?
      nil
    else
      if user.password == password
        user
      else
        nil
      end
    end
  end
end
