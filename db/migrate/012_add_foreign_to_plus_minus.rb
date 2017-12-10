Sequel.migration do
  up do
    alter_table(:plus_minus) do
      add_foreign_key [:player_id], :players
    end
  end

  down do
  end
end
