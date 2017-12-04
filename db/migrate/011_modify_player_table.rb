Sequel.migration do
  up do
    alter_table(:players) do
      drop_column :id
      rename_column :jersey_number, :id
      add_primary_key [:id]
    end
  end

  down do
  end
end
