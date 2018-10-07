require 'sqlite3'
require 'sequel'
require 'terminal-table'

require_relative 'config.rb'
require_relative '../models/game'
require_relative '../models/goal'
require_relative '../models/player'
require_relative '../models/plus_minus'
require_relative '../models/team'

MAIN_MENU = "
      ## Game ##

      [a]dd [ga]ame
      [a]dd [ga]ame [s]tats
      [p]rint [ga]mes
      [p]rint [ga]me by [id]
      [d]elete [ga]ame

      ## Goal ##

      [a]dd [g]oal
      [p]rint [g]oals
      [d]elete [g]oals

      ## Plus Minus ##

      [p]lus_minus
      [p]rint [p]lus [m]inus

      ## Player ##

      [a]dd [pl]ayer
      [p]rint [pl]ayers
      [d]elete [pl]ayer

      ## Team ##

      [a]dd [t]eam
      [p]rint [t]eams: ".freeze

# Add Game
def aga
  Game.add
end

# Add game stats
def agas
  Game.add_stats
end

# Print Games
def pga
  Game.print_all
end

# Print game by id
def pgaid
  system('clear')
  Game.print_all
  puts 'What is the id of game: '
  Game.print(gets.chomp)
end

# Delete Game
def dga
  system('clear')
  Game.print_all
  puts 'What is the game id you want to delete(BE CAREFUL!!): '
  game_id = gets.chomp
  Game.where(id: game_id).delete
end

# Add goals
def ag
  Goal.add
end

# Print goals
def pg
  Goal.print_all
end

# Print plus minus
def ppm
  PlusMinus.print_all
end

# Add Player
def apl
  puts 'What is the Jersy Number: '
  jersey_number = gets.chomp
  puts 'What is the players first name: '
  first_name = gets.chomp
  puts 'What is the players last name: '
  last_name = gets.chomp
  player = Player.new
  player.id = jersey_number
  player.first_name = first_name
  player.last_name = last_name
  player.save
  Player.print_all
end

# Print all players
def ppl
  Player.print_all
end

# Delete Player
def dpl
  Player.print_all
  puts 'ID of player you want to delete(BE CAREFULL!!!): '
  player_id = gets.chomp
  PlusMinus.where(player_id: player_id).delete
  Goal.where(player_id: player_id).delete
  Player.where(id: player_id).delete
  puts "Player #{player_id} has been deleted!"
  Player.print_all
end

# Add Team
def at
  Team.print_all
  Team.add
  system('clear')
  Team.print_all
end

# Print Teams
def pt
  Team.print_all
end

def main_menu
  system('clear')
  puts MAIN_MENU

  send(gets.chomp)
end

main_menu
