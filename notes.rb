
require 'erb'

meaning_of_life = 42

question = "The Answer to the Ultimate Question of Life, the Universe, and Everything is <%= meaning_of_life %>"
template = ERB.new question

results = template.result(binding)
puts results







# If the phone number is less than 10 digits assume that it is a bad number and use 000-000-0000
# If the phone number is 10 digits assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number and use 000-000-0000
# If the phone number is more than 11 digits assume that it is a bad number and use 000-000-0000
