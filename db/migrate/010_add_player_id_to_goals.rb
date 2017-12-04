Sequel.migration do
  up do
    alter_table(:goals) do
      add_foreign_key :player_id, :players
    end
  end

  down do
    alter_table(:goals) do
      drop_foreign_key :player_id
    end
  end
end
