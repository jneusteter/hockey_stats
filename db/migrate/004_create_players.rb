Sequel.migration do
  up do
    create_table :players do
      primary_key :id
      Integer :jersey_number
      String :first_name
      String :last_name
    end
  end

  down do
    drop_table :players
  end
end
