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
    def self.oneYearPasses
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
    def self.countTheOranges
        puts 'There are currently ' + @@oranges.to_s + ' oranges on your tree.'
    end

    # reduces orange count by one
    def self.pickAnOrange
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
        puts 'oneYearPasses'
        puts 'countTheOranges'
        puts 'pickAnOrange'
    end
end

OrangeTree.new

# defines a function that gets user input and returns it
def userEntry
    puts 'Type the command you want to run below.'
    getString = gets.chomp
    return getString
end

linebreak = '-----------------------------------------------------'
entry = userEntry
while entry != 'exit'
    if entry == 'height'
        puts linebreak
        OrangeTree.height()
        puts linebreak
        puts
    elsif entry == 'oneYearPasses'
        puts linebreak
        OrangeTree.oneYearPasses()
        puts linebreak
        puts
    elsif entry == 'countTheOranges'
        puts linebreak
        OrangeTree.countTheOranges()
        puts linebreak
        puts
    elsif entry == 'pickAnOrange'
        puts linebreak
        puts OrangeTree.pickAnOrange()
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
    entry = userEntry
end