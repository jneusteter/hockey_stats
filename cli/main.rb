require 'sqlite3'
require 'sequel'
require 'terminal-table'
require_relative 'config.rb'

require_relative './add_goal'
require_relative './add_plus_minus'
require_relative '../models/account'
require_relative '../models/game'
require_relative '../models/goal'
require_relative '../models/player'
require_relative '../models/plus_minus'
require_relative '../models/team'

def get_period
  puts 'Which period? [4 = overtime]'
  gets.chomp
end

def backup_db
  system("cp ../db/hockey_stats_tracker_production.db ./backups/#{Time.now.strftime('%b%d%Y:%I:%M:%S%p')}_backup.db")
end

def get_game_id
  last_game_id = Game.last[:id]

  # Game ID
  puts "What is the game id?[Default = #{last_game_id}] "
  game_id = gets.chomp
  game_id = last_game_id if game_id == ''

  return game_id
  puts "The game ID is #{game_id}"
end

system('clear')
puts "
      ## Game ##\n
      [a]dd [ga]ame
      [a]dd [ga]ame [s]tats
      [p]rint [ga]mes
      [p]rint [ga]me by [id]
      [d]elete [ga]ame\n
      ## Goal ##\n
      [a]dd [g]oal
      [p]rint [g]oals
      [d]elete [g]oals\n
      ## Plus Minus ##\n
      [p]lus_minus
      [p]rint [p]lus [m]inus\n
      ## Player ##\n
      [a]dd [pl]ayer
      [p]rint [pl]ayers
      [d]elete [pl]ayer: "

case gets.chomp
# Game
when 'aga'
  Game.add
when 'agas'
  Game.add_stats
when 'pga'
  Game.print_all
when 'pgaid'
  system('clear')
  Game.print_all
  puts 'What is the id of game: '
  Game.print(gets.chomp)
when 'dga'
  system('clear')
  Game.print_all
  puts 'What is the game id you want to delete(BE CAREFUL!!): '
  game_id = gets.chomp
  Game.where(id: game_id).delete
# Goal
when 'g'
  add_goal
when 'p'
  plus_minus
when 'pg'
  Goal.print_all
# Plus Minus
when 'ppm'
  PlusMinus.print_all
# Players
when 'apl'
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
when 'ppl'
  Player.print_all
when 'dpl'
  Player.print_all
  puts 'ID of player you want to delete(BE CAREFULL!!!): '
  player_id = gets.chomp
  PlusMinus.where(player_id: player_id).delete
  Goal.where(player_id: player_id).delete
  Player.where(id: player_id).delete
  puts "Player #{player_id} has been deleted!"
  Player.print_all
else
  'not cool'
end
