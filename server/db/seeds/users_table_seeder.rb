require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative '../../models'

recs = [{
  :name=>'Habib',
  :email=>'habib@idefi.in',
  :password=>'habib@idefi.in',
  :contact_no=>'9987654321',
  :address=>'Whitefield, Bangalore, India'
}]

recs.each do |rec|
  User.create_user(rec) if User.where(:email=>rec[:email]).count < 1
end