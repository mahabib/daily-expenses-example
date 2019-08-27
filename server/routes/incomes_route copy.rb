require_relative '../helpers/json-web-token'

App.route("incomes") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |income_id|
    r.get do
      income = @current_user.incomes.where(id: income_id).first
      raise "Invalid Income!" if !income
      {
        success: true,
        values: income.values
      }
    end

    r.put do
      income.update_income(params)
      {
        success: true
      }
    end

    r.delete do
      income.destroy
      {
        success: true
      }
    end
  end # /expense-categories/:id
  r.post do
    Income.create_income(@current_user, params)
    {
      success: true
    }
  end

  r.get do
    {
      success: true,
      values: Income.all.collect{|u| u.values}
    }
  end
end