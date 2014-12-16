require 'pg'
require 'active_record'

require 'sinatra'
require 'sinatra/reloader'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'growler_db'
)

class User < ActiveRecord::Base
	has_many :posts 
	validates :username, presence: true, uniqueness: true
end

class Post < ActiveRecord::Base
	belongs_to :user
	validates :body, presence: true
end

# post '/createuser/:username'
# 	@username = params[:username]
# 	@user = User.create(username: @username)
# end

get '/:name' do
	@name = params[:name]
	@user = User.find_by(username: @name)
	@posts = @user.posts
	return erb :userposts
end

post '/:newpost' do
	@user_id = params[:user_id]
	@body = params[:body]
	posts.create(body: post, user_id: user_id)
end
