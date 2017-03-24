require './ctf_scoreboard'

class UserLoggerWardenManager < Warden::Manager
  def call(env)
    result = super
    if env['warden'].authenticated?
      name = env['warden'].user.name
      name = name.split(' ').join
      env['REMOTE_USER'] = name
    end
    result
  end
end

app = Rack::Builder.new do
  #use Warden::Manager do |manager|
  use UserLoggerWardenManager do |manager|
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
      params['name'] && params['password']
    end
    def authenticate!
      user = User.authenticate(params['name'], params['password'])
      user.nil? ? fail!('Could not login') : success!(user)
    end
  end

  run CtfScoreboard
end

run app
