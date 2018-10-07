Sequel.migration do
  up do
    alter_table(:goals) do
      drop_column :game_id
      add_foreign_key :game_id, :games
      drop_column :assist_one
      add_foreign_key :assist_one, :players
    end
  end
  down do
  end
end
