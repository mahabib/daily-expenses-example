require_relative '../helpers/json-web-token'

App.route("auth") do |r|
  r.post "register" do
    User.create_user(params)
    {
      success: true
    }
  end

  r.post "verify-otp" do
    @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
    @current_user.verify_otp(params)
    {
      success: true
    }
  end
  
  r.post "login" do
    {
      success: true,
      values: User.login(params)
    }
  end
end