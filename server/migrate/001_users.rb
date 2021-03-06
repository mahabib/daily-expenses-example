Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :name, :null=>false
      String :email, :unique=>true, :null=>false
      String :password, :null=>false
      String :contact_no
      Text :address
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:users)
  end
end