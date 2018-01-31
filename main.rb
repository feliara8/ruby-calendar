require_relative 'calendar'
require_relative 'exceptions'
require 'readline'

bnd = binding()

loop do
  puts 'Enter a command:'
  puts ""
  expression = Readline.readline("> ", true)
  break if expression == 'quit' || expression == 'exit'
  begin
    result = bnd.eval(expression)
  rescue SyntaxError
    puts 'Wrong syntax'
  rescue StandardError => e
    puts e.message
  end
  puts result
  puts ""
end
