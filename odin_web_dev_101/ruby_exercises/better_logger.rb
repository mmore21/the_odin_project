$nesting_depth = 0
$space = ' '

def log block_description, &block
    puts ($space * $nesting_depth) + 'Beginning "' + block_description + '"...'
    $nesting_depth = $nesting_depth + 1
    return_value = block.call
    $nesting_depth = $nesting_depth - 1
    puts ($space * $nesting_depth) + block_description + '" finished, returning: ' + return_value.to_s
end

driveMotorcycle = Proc.new do
    puts 'Vroooooooom'
end

log 'outer block' do

log 'some little block' do

    log 'yet another block' do
        'I like Thai food!'
    end

    5
end

false
end