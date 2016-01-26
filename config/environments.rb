#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production, :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://xeuqunygyaxxxv:f7RVOavZHHpP_SFrunnlEN1ErQ@ec2-54-225-195-249.compute-1.amazonaws.com:5432/do4clntk7ijkk')

	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
end
