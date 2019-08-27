class IncomeCategory < Sequel::Model
  one_to_many :incomes,
    :key => :income_category_id,
    :class => :Income
  
  many_to_one :user,
    :key => :user_id,
    :class => :User

  def self.create_income_category(user, params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if IncomeCategory.where(name: params[:name]).count > 0
    
    self.create(
      user_id: user.id,
      name: params[:name],
      description: params[:description]
    )
  end

  def update_income_category(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if IncomeCategory.where(name: params[:name]).count > 0

    update(
      name: params[:name],
      description: params[:description]
    )
  end
end