Sequel.migration do
  up do
    create_table(:contacts) do
      primary_key :id
      String :name, :null=>false
      String :email
      String :contact_no, :null=>false
      Text :address
      Text :notes
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:contacts)
  end
end