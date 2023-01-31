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

h_player = HumanPlayer.new(name)

player1 = Player.new("Josiane")
player2 = Player.new("José")
ennemies = [player1, player2]

while h_player.life_points > 0 && (player1.life_points + player2.life_points) >0
    h_player.show_state

    puts "Quelle action veux tu effectuer ? \n a- chercher une meilleure arme \n s- chercher un health_pack \n 
    Attaquer un joueur : \n 1- #{player1.name} qui a #{player1.life_points} points de vie \n 2- #{player2.name} qui a #{player2.life_points} points de vie"
    print '>'
    choice = gets.chomp

    case choice
    when "a"
        h_player.search_weapon
    when "s"
        h_player.search_health_pack
    when "1"
        h_player.attacks(player1)
    when "2"
        h_player.attacks(player2)
    else
        puts "ce n'est pas un choix valide, try again"
    end

    sum_lp=0
    ennemies.map{|ennemy| sum_lp = sum_lp + ennemy.life_points}
    if sum_lp > 0 
        puts "Les autres joueurs t'attaquent !\n\n"
    end
    ennemies.each do |ennemy|
        if ennemy.life_points > 0 
        ennemy.attacks(h_player)
        end
    end
end

puts "La partie est FINIE !"
h_player.life_points > 0? (puts "BRAVO TU AS GAGNE !") : (puts "Oho.. you lost")