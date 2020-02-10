require './lexer/main.rb'
require './runner/main.rb'

@code = ARGF.read
@chomp = @code.gsub("\n", " <br> ").split(" ")
# @token = []
# puts "-------------start--------"
# puts "-------------data---------"
print "chomp: "
p @chomp
# puts "-------------lexer--------"
@token = Lexer.new(@chomp).run
# puts "-------------data---------"
print "token: "
p @token
# puts "-------------runer--------"
Runner.new(@token).run(0,@token.size)
# puts "-------------finish-------"
