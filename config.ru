require './ctf_scoreboard'

app = Rack::Builder.new do
  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = CtfScoreboard
    manager.serialize_into_session do |user|
      user.id
    end
    manager.serialize_from_session do |id|
      User.where(_id: id).first
    end
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['email'] && params['password']
    end
    def authenticate!
      user = User.authenticate(params['email'], params['password'])
      user.nil? ? fail!('Could not login') : success!(user)
    end
  end

  run CtfScoreboard
end

run app
