Sequel.migration do
  up do
    alter_table(:plus_minus) do
      set_column_type :game_id, :String
    end
  end

  down do
  end
end
