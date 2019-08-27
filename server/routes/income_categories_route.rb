require_relative '../helpers/json-web-token'

App.route("income-categories") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |income_category_id|
    r.get do
      income_category = @current_user.income_categories.where(id: income_category_id).first
      raise "Invalid Income Category!" if !income_category
      {
        success: true,
        values: income_category.values
      }
    end

    r.put do
      income_category.update_income_category(params)
      {
        success: true
      }
    end

    r.delete do
      income_category.destroy
      {
        success: true
      }
    end
  end # /expense-categories/:id
  r.post do
    IncomeCategory.create_income_category(@current_user, params)
    {
      success: true
    }
  end

  r.get do
    {
      success: true,
      values: IncomeCategory.all.collect{|u| u.values}
    }
  end
end