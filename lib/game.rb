require 'pry'
require_relative 'player'

class Game
    attr_accessor :human_player, :ennemies, :players_left, :ennemies_in_sight

    def initialize(name)
        @human_player = HumanPlayer.new(name)
        #player1 = Player.new("Josiane")
        #player2 = Player.new("José")
        #player3 = Player.new("Jerome")
        #player4 = Player.new("Tristan")
        #@ennemies = [player1, player2, player3, player4]
        @players_left = 10
        @ennemies_in_sight = []

    end

    def kill_player(player)
        @ennemies_in_sight -= [player]
    end

    def is_still_ongoing?
        (@human_player.life_points > 0 && @players_left > 0)? true : false
    end

    def show_players
        @human_player.show_state
        puts "Il reste #{@players_left} bots à vaincre \n\n"
    end

    def menu
        puts "Quelle action veux tu effectuer ? \n a- chercher une meilleure arme \n s- chercher un health_pack \n\n Attaquer un joueur : \n"
        i = 1
        @ennemies_in_sight.each do |ennemy| 
            puts "#{i}- #{ennemy.name} qui a #{ennemy.life_points} points de vie \n "
            i += 1
        end
        print '>'
    end

    def menu_choice(string)
        case string
        when "a"
            @human_player.search_weapon
        when "s"
            @human_player.search_health_pack
        else
            if  string.to_i >0 && string.to_i <= @ennemies_in_sight.length
                @human_player.attacks(@ennemies_in_sight[string.to_i - 1])
                if (@ennemies_in_sight[string.to_i - 1]).life_points == 0
                    kill_player(@ennemies_in_sight[string.to_i - 1])
                    @players_left -= 1
                end
            else
                puts  "ce n'est pas un choix valide, try again"
            end
        end
    end

    def ennemies_attack
        sum_lp=0
        @ennemies_in_sight.map{|ennemy| sum_lp = sum_lp + ennemy.life_points}
        if sum_lp > 0 
             puts "Les autres joueurs t'attaquent !\n\n"
        end
        @ennemies_in_sight.each do |ennemy|
            ennemy.attacks(@human_player)
        end
    end

    def new_players_in_sight
        if @ennemies_in_sight.length == @players_left
            puts "Tous les joueurs sont déjà en jeu\n\n"
        else
            dice = rand(1..6)
            case dice
            when 1
                puts "Ouf, pas de nouvel ennemi"
            when 5..6
                2.times do |i|
                name_i = "player" + rand(100..999).to_s
                name_i = Player.new(name_i)
                @ennemies_in_sight.push(name_i)
                end
                puts "Deux nouveaux adversaires arrivent\n\n"
            when 2..4
                name = "player" + rand(100..999).to_s
                name = Player.new(name)
                @ennemies_in_sight.push(name)
                puts "Un nouvel adversaire arrive\n\n"
            end
        end
    end

    def end
        puts "La partie est FINIE !"
        @human_player.life_points > 0? (puts "BRAVO TU AS GAGNE !") : (puts "Oho.. you lost")
    end
end
