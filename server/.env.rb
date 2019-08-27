ENV['RACK_ENV'] ||= "development"
ENV['RACK_SECRET'] = "YourRackSecret"
ENV['RACK_SECRET_KEY'] = "YourRackSecretKey"
ENV['APP_NAME'] ||= "daily_expenses"
ENV['PORT'] ||= "9292"
ENV['JWT_SECRET'] = 'YourJWTSecret'
ENV['JWT_ALGO'] = 'HS256'

case ENV['RACK_ENV']
when 'test'
	ENV['DB_URL'] = "sqlite://db/daily_expenses_test.db"
when 'development'
	ENV['DB_URL'] = "sqlite://db/daily_expenses_dev.db"
when 'production'
	ENV['DB_URL'] = "sqlite://db/daily_expenses_prod.db"
else
end
