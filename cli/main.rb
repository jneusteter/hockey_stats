require 'sqlite3'
require 'sequel'
require_relative 'config.rb'

require_relative './add_game'
require_relative './add_goal'
require_relative './add_plus_minus'
require_relative '../models/account'
require_relative '../models/factory_bot_sequel'
require_relative '../models/game'
require_relative '../models/goal'
require_relative '../models/player'
require_relative '../models/plus_minus'
require_relative '../models/team'

def clear
  system('clear')
end

def print_players
  Player.all.each do |player|
    puts "#{player[:id]} => #{player[:first_name]} #{player[:last_name]}"
  end
end

def print_games
  Game.all.each do |game|
    puts "#{game[:id]}, #{game[:datetime_played]} against #{game[:team_id]}"
  end
end

def print_goals
  Goal.all.each do |goal|
    puts "#{goal[:game_id]} | Scored By => #{goal[:scored_by]} in the #{goal.period} period, A1 #{goal[:assist_one]}, A2 #{goal[:assist_two]}"
  end
end

def print_plus_minus
  PlusMinus.all.each do |plus|
    puts "#{plus[:game_id]} #{plus[:player_id]} #{plus[:plus_minus]}"
  end

  Player.all.each do |player|
    puts "#{player[:id]} #{player[:last_name]} (#{PlusMinus.where(player_id: player[:id]).sum(:plus_minus)})"
  end
end

def get_period
  puts 'Which period? [4 = overtime]'
  gets.chomp
end

def backup_db
  t = Time.now
  system("cp ../db/hockey_stats_tracker_production.db ./backups/#{t.strftime("%b%d%Y:%I:%M:%S%p")}_backup.db")
end

def get_game_id
  last_game_id = Game.last[:id]

  # Game ID
  puts "What is the game id?[Default = #{last_game_id}] "
  game_id = gets.chomp
  if game_id == ''
    game_id = last_game_id
  end

  return game_id
  puts "The game ID is #{game_id}"
end

def first_prompt
  clear
  puts "[a]dd [g]ame\n[g]oal\n[p]lus_minus\n[p]rint [g]oals\n[p]rint [p]lus [m]inus\n[p]rint [ga]mes\n[pr]int [pl]ayers: "

  case gets.chomp
  when 'ag'
    add_game
  when 'g'
    add_goal
  when 'p'
    plus_minus
  when 'pg'
    print_goals
  when 'ppm'
    print_plus_minus
  when 'pga'
    print_games
  when 'prpl'
    print_players
  else
    'not cool'
  end
end

first_prompt
