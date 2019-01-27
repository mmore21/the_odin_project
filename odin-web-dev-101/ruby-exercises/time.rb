birthdate = Time.now.to_i - Time.mktime(2000, 4, 6).to_i

puts 'You have been alive for ' + birthdate.to_s + ' seconds.'

billion_date = Time.mktime(2000, 4, 6) + 1000000000

puts 'You will be one billion seconds old on ' + billion_date.to_s + ' '

def user_age(year, month, day)
    return (Time.now - Time.mktime(year, month, day)).to_i
end

puts 'Enter the year you were born: '
get_year = gets.chomp.to_i
puts 'Enter the month you were born: '
get_month = gets.chomp.to_i
puts 'Enter the day you were born: '
get_day = gets.chomp.to_i

age_second = user_age(get_year, get_month, get_day)
age_minute = ((user_age(get_year, get_month, get_day).to_i)/60)
age_hour = ((user_age(get_year, get_month, get_day).to_i)/3600)
age_day = ((user_age(get_year, get_month, get_day).to_i)/(3600 * 24))
age_year = ((user_age(get_year, get_month, get_day).to_i)/(3600 * 24 * 365))

puts 'You are ' + age_second.to_s + ' seconds old.'
puts 'You are ' + age_minute.to_s + ' minutes old.'
puts 'You are ' + age_hour.to_s + ' hours old.'
puts 'You are ' + age_day.to_s + ' days old.'
puts 'You are ' + age_year.to_s + ' years old.'

birthday_count = 0
while birthday_count <= age_year
    if birthday_count == 0
        puts 'SPANK! (You were born!)'
    else
        puts 'SPANK! (for your ' + birthday_count.to_s + ' birthday)'
    end
    birthday_count += 1
end