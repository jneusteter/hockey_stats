class Player < Sequel::Model
  one_to_many :goals
  one_to_many :plus_minus

  def self.print_all
    system('clear')
    all.each do |player|
      puts "#{player[:id]} => #{player[:first_name]} #{player[:last_name]}"
    end
  end
end
