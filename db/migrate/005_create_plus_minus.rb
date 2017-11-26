Sequel.migration do
  up do
    create_table :plus_minus do
      primary_key :id
      Integer :game_id
      Integer :player_id
      Integer :plus_minus
      Integer :period
    end
  end

  down do
    drop_table :plus_minus
  end
end
