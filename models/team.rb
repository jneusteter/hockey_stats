class Team < Sequel::Model
  one_to_many :games

  def self.print_all
    system('clear')
    all.each do |team|
      puts "#{team[:id]} => #{team[:town]} #{team[:name]}"
    end
  end

  def self.add
    team = Team.new
    puts 'What is the town: '
    team.town = gets.chomp
    puts 'What is the team name: '
    team.name = gets.chomp
    puts 'What is the team category: '
    team.category = gets.chomp
    team.save
  end
end
