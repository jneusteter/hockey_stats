Sequel.migration do
  up do
    alter_table(:goals) do
      set_column_type :game_number, :String
    end
  end

  down do
  end
end
