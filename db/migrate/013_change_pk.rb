Sequel.migration do
  up do
    alter_table(:games) do
      drop_column :id
      rename_column :game_number, :id
      add_primary_key [:id]
    end
  end

  down do
  end
end
