require_relative '../helpers/json-web-token'

App.route("expenses") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |expense_id|
    r.get do
      expense = @current_user.expense_categories.where(id: expense_id).first
      raise "Invalid Expense Category!" if !expense
      {
        success: true,
        values: expense.values
      }
    end

    r.put do
      expense.update_expense(params)
      {
        success: true
      }
    end

    r.delete do
      expense.destroy
      {
        success: true
      }
    end
  end # /expenses/:id
  r.post do
    Expense.create_expense(@current_user, params)
    {
      success: true
    }
  end

  r.get do
    {
      success: true,
      values: Expense.all.collect{|u| u.values}
    }
  end
end