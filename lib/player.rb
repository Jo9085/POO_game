require 'pry'

class Player
    attr_accessor :name, :life_points

    def initialize(name)
        @name = name
        @life_points = 10
    end

    def show_state
        puts "#{name} a #{life_points} points de vie"
    end

    def gets_damage(points)
        @life_points -= points
        @life_points < 0? @life_points = 0 : nil #min de life_point à 0

        #if @life_points <= 0
         #   puts "le joueur #{name} a été tué !"
        #end
        @life_points == 0? (puts "Le joueur #{name} a été tué!") : nil
    end

    def attacks(player)
        puts "Le joueur #{self.name} attaque le joueur #{player.name}"
        result = compute_damage
        puts "Il lui inflige #{result} points de dommage"
        puts player.gets_damage(result)
    end

    def compute_damage
        return rand(1..6)
    end
end


class HumanPlayer < Player
    attr_accessor :life_points, :weapon_level

    def initialize(name)
        super(name)
        @life_points = 100
        @weapon_level = 1
    end

    def show_state
        puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}"
        puts
    end

    def compute_damage
        rand(1..6) * @weapon_level
    end

    def search_weapon
        dice = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{dice}\n\n"

        if dice > @weapon_level
            @weapon_level = dice
            puts "Youhou, elle est meilleure que ton arme actuelle, tu la prends !\n\n"
        else
            puts "Gloups, elle n'est pas mieux..\n\n"
        end
    end

    def search_health_pack
        dice = rand(1..6)
        case dice
        when 1
            puts "Tu n'as rien trouvé.."
        when 6
            @life_points += 80
            @life_points > 100? @life_points = 100 : nil #max de life_point à 100
            puts "Wahou, tu as trouvé un pack de +80 points de vie !\n\n"
        else
            @life_points += 50
            @life_points > 100? @life_points = 100 : nil
            puts "Bravo, tu as trouvé un pack de +50 points de vie !\n\n"
        end
    end


end