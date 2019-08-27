ENV['RACK_ENV'] ||= "development"
ENV['RACK_SECRET'] = "YourRackSecret"
ENV['RACK_SECRET_KEY'] = "YourRackSecretKey"
ENV['APP_NAME'] ||= "daily-expenses"
ENV['PORT'] ||= "9292"
ENV['JWT_SECRET'] = 'YourJWTSecret'
ENV['JWT_ALGO'] = 'HS256'

case ENV['RACK_ENV']
when 'test'
	ENV['DB_URL'] = "sqlite://db/daily-expenses-test.db"
when 'development'
	ENV['DB_URL'] = "sqlite://db/daily-expenses-dev.db"
when 'production'
	ENV['DB_URL'] = "sqlite://db/daily-expenses-prod.db"
else
end
