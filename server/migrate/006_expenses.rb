Sequel.migration do
  up do
    create_table(:expenses) do
      primary_key :id

      foreign_key :user_id,
        :users,
        :key => :id,
        :allow_null => false

      foreign_key :expense_category_id,
        :expense_categories,
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
    drop_table(:expenses)
  end
end