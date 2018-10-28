Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      String :name, :size=>255
      String :surname, :size=>255
      String :email, :size=>255
      String :crypted_password, :size=>255
      String :role, :size=>255
    end
    
    create_table(:games) do
      String :id, :size=>255
      Integer :team_id
      DateTime :datetime_played
      String :home_away, :size=>255
      String :type, :size=>255
      
      primary_key [:id]
    end
    
    create_table(:players) do
      primary_key :id
      String :first_name, :size=>255
      String :last_name, :size=>255
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:teams) do
      primary_key :id
      String :town, :size=>255
      String :name, :size=>255
      String :category, :size=>255
    end
    
    create_table(:goals) do
      primary_key :id
      Integer :assist_two
      Integer :period
      foreign_key :player_id, :players
      foreign_key :game_id, :games
      foreign_key :assist_one, :players
    end
    
    create_table(:plus_minus) do
      primary_key :id
      String :game_id
      foreign_key :player_id, :players
      Integer :plus_minus
      Integer :period
    end
  end
end
