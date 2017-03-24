class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :score, type: Integer, default: 0
  field :affiliation, type: String, default: ''
  field :hide, type: Boolean, default: false

  has_and_belongs_to_many :flags

  validates_uniqueness_of :name
  validates_presence_of :name, :password, :score

  AFFILIATIONS = {
    'smu.edu' => 'SMU',
    'utdallas.edu' => 'UTD',
    'unt.edu' => 'UNT',
    'cigital.com' => 'Cigital'
  }

  def update_score
    self.score = flags.to_a.map(&:points).inject(&:+)
    save
  end

  def self.authenticate(name, password)
    user = User.where(name: name).first
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
