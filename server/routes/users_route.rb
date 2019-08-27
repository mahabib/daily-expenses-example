require_relative '../helpers/json-web-token'

App.route("users") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |user_id|
    user = User[user_id]
    raise "Invalid User!" if !user
    r.get do
      {
        success: true,
        values: user.values
      }
    end

    r.put do
      user.update_user(params)
      {
        success: true
      }
    end

    r.delete do
      user.destroy
      {
        success: true
      }
    end
  end # /users/:id

  r.get do
    {
      success: true,
      values: User.all.collect{|u| u.values}
    }
  end
end