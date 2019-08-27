class ExpenseCategory < Sequel::Model
  one_to_many :expenses,
    :key => :expense_category_id,
    :class => :Expense
  
  many_to_one :user,
    :key => :user_id,
    :class => :User

  def self.create_expense_category(user, params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if ExpenseCategory.where(name: params[:name]).count > 0
    
    self.create(
      user_id: user.id,
      name: params[:name],
      description: params[:description]
    )
  end

  def update_expense_category(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if ExpenseCategory.where(name: params[:name]).count > 0

    update(
      name: params[:name],
      description: params[:description]
    )
  end
end