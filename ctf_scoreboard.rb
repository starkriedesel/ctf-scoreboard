require 'bundler'
Bundler.require
require './models/user'
require './models/track'
require './models/flag'

Mongoid.load!('./mongoid.yml', :development)

require './seed'
seed!

class CtfScoreboard < Sinatra::Base
  register Sinatra::Warden
  enable :sessions
  set :session_secret, "secretKey"
  use Rack::Flash, sweep: true

  get '/login' do
    @error = env['x-rack.flash'][:error]
    haml :login
  end

  # Redirec to login or scoreboard
  get '/' do
    redirect to('/login') if current_user.nil?
    redirect to('/tracks')
  end

  get '/rules' do
    haml :rules
  end

  # Show progress of players
  get '/scoreboard' do
    @users = User.where(hide: false).all.to_a
    @tracks = Track.all.to_a
    unless params[:track].nil?
      @track = Track.where(name: params[:track]).first
      @users = @users.map do |user|
        track_flags = user.flags.select{|flag| flag.track.id == @track.id}
        user.score = track_flags.map(&:points).inject(:+)
        user
      end
      @users.each {|u| u.score = u.score.to_i}
    end
    haml :scoreboard
  end

  # Show player progress and flag submision
  get '/tracks' do
    authorize!
    @user = current_user
    @tracks = Track.all.order_by(order: :asc).to_a
    haml :tracks
  end

  get '/track/:id' do
    authorize!
    @user = current_user
    @track = Track.find(params[:id])
    begin
      haml :"#{@track.view}", layout: :track_layout
    rescue
      haml :track_no_details, layout: :track_layout
    end
  end

  get '/flag/:id' do
    authorize!
    @user = current_user
    @flag = Flag.find(params[:id])
    @track = @flag.track
    begin
      haml :"#{@flag.view}", layout: :track_layout
    rescue
      haml :flag_no_hints, layout: :track_layout
    end
  end

  # Submit a flag
  post '/flag' do
    authorize!
    @user = current_user
    if params['value'].blank?
      flash[:error] = 'No flag submited'
    else
      flags = Flag.where(value: params['value'])
      if flags.count == 0
        flash[:error] = 'Incorrect flag value'
      elsif flags.count > 1
        flash[:error] = 'Multiple flags matched'
      else
        flag = flags.first
        if flag.locked or flag.track.locked
          flash[:error] = 'The flag or track is locked'
        elsif @user.flags.include? flag
          flash[:error] = 'You have already submitted this flag'
        else
          @user.flags << flag
          @user.update_score
          flash[:success] = "Flag &laquo;#{flag.track.name} #{flag.name}&raquo; submitted! You earned #{flag.points} points"
        end
      end
    end
    redirect to('/tracks')
  end

  post '/register' do
    @user = User.new({
      email: params[:email]
    })
    if @user.email.blank?
      flash[:error] = 'Email is required'
      redirect to('/login')
    elsif User.where(email: @user.email).count > 0
      flash[:error] = 'Email is already registers'
      redirect to('/login')
    else
      email_parts = params[:email].split('@')
      domain = email_parts.last.split('.').last(2).join('.')
      @user.affiliation = User::AFFILIATIONS[domain] || ''
      haml :register
    end
  end

  post '/register/complete' do
    @user = User.new({
      email: params[:email],
      name: params[:name],
      password: params[:password],
      affiliation: params[:affiliation]
    })
    if params[:password] != params[:confirm]
      flash[:error] = 'Password confirmation doesn\'t match password'
    elsif @user.valid?
      if @user.save
        login params
        redirect to('/rules')
        return
      else
        flash[:error] = 'User could not be saved to database'
      end
    else
      flash[:error] = @user.errors.full_messages.join '; '
    end
    haml :register
  end

  get '/layout.css' do
    scss :layout
  end

  run! if app_file == $0
end
