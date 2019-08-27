class Income < Sequel::Model
  many_to_one :income_category,
    :key => :income_category_id,
    :class => :IncomeCategory
  
  many_to_one :user,
    :key => :user_id,
    :class => :User

  many_to_one :contact,
    :key => :contact_id,
    :class => :Contact

  def self.create_income(user, params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Category is required!" if !params[:income_category_id]
    raise "Date is required!" if !params[:date]
    raise "Amount is required!" if !params[:amount]
    raise "Description is required!" if !params[:description]
    
    income_category = ExpenseCategory[params[:income_category_id]]
    raise "Invalid Category!" if !income_category

    if params[:contact_id]
      contact = Contact[params[:contact_id]]
      raise "Invalid contact!" if !contact
    end

    self.create(
      user_id: user.id,
      income_category_id: income_category.id,
      contact_id: contact ? contact.id : nil,
      date: Time.parse(params[:date]),
      amount: params[:amount],
      description: params[:description]
    )
  end

  def update_income(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Category is required!" if !params[:income_category_id]
    raise "Date is required!" if !params[:date]
    raise "Amount is required!" if !params[:amount]
    raise "Description is required!" if !params[:description]

    income_category = ExpenseCategory[params[:income_category_id]]
    raise "Invalid Category!" if !income_category

    if params[:contact_id]
      contact = Contact[params[:contact_id]]
      raise "Invalid contact!" if !contact
    end

    update(
      income_category_id: income_category.id,
      contact_id: contact ? contact.id : nil,
      date: Time.parse(params[:date]),
      amount: params[:amount],
      description: params[:description]
    )
  end
end