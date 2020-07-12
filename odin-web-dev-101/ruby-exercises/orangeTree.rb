class OrangeTree

    # defines all class variables needed
    def initialize
        @@age = 0
        @@height = 0
        @@oranges = 0
        puts 'Welcome, you just planted an orange tree! Type \'commands\' to view a list of commands!'
        puts 'Type \'exit\' to exit the program.'
    end

    # returns the height of the tree
    def self.height
        puts 'The orange tree is ' + @@height.to_s + ' feet tall!'
    end

    # ages the year one year upon being called
    def self.one_year_passes
        orangesDie = 'The winter has passed and all of the oranges from last year died.'
        @@age += 1
        @@height += 3
        @@oranges = 0
        if @@age <= 2
            @@oranges += 0
        elsif @@age >= 3 && @@age <= 6
            puts orangesDie
            @@oranges += 3
        elsif @@age >= 7 && @@age <=9
            puts orangesDie
            @@oranges += 5
        else
            puts 'Oh boy, your tree died! :('
            return 'exit'
        end
        puts 'Your tree is now ' + @@age.to_s + ' years old, ' + @@height.to_s + ' feet tall, and has ' + @@oranges.to_s + ' oranges!'
    end

    # returns the amount of oranges on tree
    def self.count_the_oranges
        puts 'There are currently ' + @@oranges.to_s + ' oranges on your tree.'
    end

    # reduces orange count by one
    def self.pick_an_orange
        if @@oranges > 0
            @@oranges -= 1
            puts 'Yum, that orange was delicious!'
            puts 'There are now ' + @@oranges.to_s + ' oranges left on the tree.'
        else
            puts 'Sorry, there are no oranges on your tree.'
        end
    end

    def self.commands
        puts 'height'
        puts 'one_year_passes'
        puts 'count_the_oranges'
        puts 'pick_an_orange'
    end
end

OrangeTree.new

# defines a function that gets user input and returns it
def user_entry
    puts 'Type the command you want to run below.'
    entry = gets.chomp
    return entry
end

linebreak = '-----------------------------------------------------'
entry = user_entry
while entry != 'exit'
    if entry == 'height'
        puts linebreak
        OrangeTree.height()
        puts linebreak
        puts
    elsif entry == 'one_year_passes'
        puts linebreak
        OrangeTree.one_year_passes()
        puts linebreak
        puts
    elsif entry == 'count_the_oranges'
        puts linebreak
        OrangeTree.count_the_oranges()
        puts linebreak
        puts
    elsif entry == 'pick_an_orange'
        puts linebreak
        puts OrangeTree.pick_an_orange()
        puts linebreak
        puts
    elsif entry == 'commands'
        puts linebreak
        OrangeTree.commands()
        puts linebreak
        puts
    else
        puts linebreak
        puts 'Sorry, that is not an available command.'
        puts linebreak
        puts
    end
    entry = user_entry
end