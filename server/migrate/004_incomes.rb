Sequel.migration do
  up do
    create_table(:incomes) do
      primary_key :id

      foreign_key :user_id,
        :users,
        :key => :id,
        :allow_null => false

      foreign_key :income_category_id,
        :income_categories,
        :key => :id,
        :allow_null => false

      foreign_key :member_id,
        :members,
        :key => :id,
        :allow_null => true

      Time :time, :null => false
      Float :amount, :null => false
      Text :description, :null => false
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:incomes)
  end
end