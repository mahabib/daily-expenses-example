class User < Sequel::Model
  one_to_many :income_categories,
    :key => :user_id,
    :class => :IncomeCategory
  
  one_to_many :incomes,
    :key => :user_id,
    :class => :Income

  one_to_many :expense_categories,
    :key => :user_id,
    :class => :ExpenseCategory
  
  one_to_many :expenses,
    :key => :user_id,
    :class => :Expense

  def self.create_user(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Email is required!" if !params[:name]
    raise "Email already exists!" if User.where(email: params[:email]).count > 0
    raise "Password is required!" if !params[:password]
    
    self.create(
      name: params[:name],
      email: params[:email],
      password: BCrypt::Password.create(params[:password]),
      contact_no: params[:contact_no],
      address: params[:address]
    )
  end

  def verify_otp(params)
    update(
      is_otp_verified: true,
      otp: nil,
      otp_expiry: nil
    )
  end

  def self.login(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Email is required!" if !params[:email] || params[:email] == ""
    raise "Password is required!" if !params[:password] || params[:password] == ""

    usr = User.where(email: params[:email]).first
    raise "User doesn't exist!" if !usr

    db_password = BCrypt::Password.new(usr.password)
		raise "Password doesn't match!" if(db_password != params[:password])

    time = Time.now + 4 * 3600
    token = JsonWebToken.encode({user_id: usr.id}, time)
    {
      token: token,
      exp: time.strftime("%m-%d-%Y %H:%M"),
      user: {
        name: usr.name,
        email: usr.email
      }
    }
  end

  def update_user(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    self.update(
      name: params[:name],
      contact_no: params[:contact_no],
      address: params[:address]
    )
  end

  def get_details
    del = [:password]
    values.delete_id{|k,v| del.include? k}
  end
end