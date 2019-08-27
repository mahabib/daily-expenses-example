Sequel.migration do
  up do
    create_table(:expense_categories) do
      primary_key :id

      foreign_key :user_id,
        :users,
        :key => :id,
        :allow_null => false

      String :name, :unique=>true, :null=>false
      Text :description
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:expense_categories)
  end
end