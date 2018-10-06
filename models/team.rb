class Team < Sequel::Model
  one_to_many :games

  def self.print_all
    all.each do |team|
      puts "#{team[:id]} => #{team[:town]} #{team[:name]}"
    end
  end
end
