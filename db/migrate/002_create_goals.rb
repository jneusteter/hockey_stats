Sequel.migration do
  up do
    create_table :goals do
      primary_key :id
      Integer :game_number
      Integer :scored_by
      Integer :assist_one
      Integer :assist_two
      Integer :period
    end
  end

  down do
    drop_table :goals
  end
end
