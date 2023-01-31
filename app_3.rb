require 'bundler'
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------\n"
puts "Bienvenue sur 'Ils veulent tous ma POO' !"
puts "Le but du jeu est d'être le dernier survivant !"
puts "-------------------------------------------------\n"

puts "What is your name, dear player ?"
print '> '
name = gets.chomp

my_game = Game.new(name)

while my_game.is_still_ongoing?
    my_game.show_players
    my_game.new_players_in_sight
    my_game.menu
    choice = gets.chomp
    my_game.menu_choice(choice)
    my_game.ennemies_attack
end

my_game.end