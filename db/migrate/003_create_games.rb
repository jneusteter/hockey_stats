Sequel.migration do
  up do
    create_table :games do
      primary_key :id
      String :game_number
      Integer :team_id
      DateTime :datetime_played
      String :home_away
      String :type
    end
  end

  down do
    drop_table :games
  end
end
