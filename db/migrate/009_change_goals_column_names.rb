Sequel.migration do
  up do
    alter_table(:goals) do
      drop_foreign_key :scored_by
      rename_column :game_number, :game_id
      rename_column :scored_by, :player_id
    end
  end

  down do
  end
end
