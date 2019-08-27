require_relative '../helpers/json-web-token'

App.route("expense-categories") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |expense_category_id|
    r.get do
      expense_category = @current_user.expense_categories.where(id: expense_category_id).first
      raise "Invalid Expense Category!" if !expense_category
      {
        success: true,
        values: expense_category.values
      }
    end

    r.put do
      expense_category.update_expense_category(params)
      {
        success: true
      }
    end

    r.delete do
      expense_category.destroy
      {
        success: true
      }
    end
  end # /expense-categories/:id
  r.post do
    ExpenseCategory.create_expense_category(@current_user, params)
    {
      success: true
    }
  end

  r.get do
    {
      success: true,
      values: ExpenseCategory.all.collect{|u| u.values}
    }
  end
end