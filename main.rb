require_relative 'calendar.rb'
require_relative 'exceptions'

loop do
  puts "Enter something:"
  puts ""
	expression = gets
	break if expression == 'quit' || expression == 'exit'
	begin
		result = eval(expression)
	rescue SyntaxError
		puts 'Wrong syntax'
	rescue StandardError => e
		puts e.message
  end
  puts result
	puts ""
end
