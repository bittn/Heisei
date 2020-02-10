class Lexer
	def initialize(chm)
		@list_token = {
			# Please write your new method setting here.
			"print"=>["PRINT","print"],
			"="=>["EQUAL","="],
			"<br>"=>["<BR>","<br>"]
		}
		@list_type  = [
			[/\d+/,"INTEGER"],
			[/".+"/,"STRING"],
			[/\w+/,"VAR"]
		]
		@chomp      = chm
		@token      = []
	end

	def run
		@i = 0
		while true
			# token判定
			if @chomp[@i]==nil
				break
			elsif @chomp[@i]=="#"
				@i+=1
				while @chomp[@i] != "#"
					@i+=1
				end
			elsif @list_token[@chomp[@i]] != nil
				@token.push(@list_token[@chomp[@i]])
			else
				sum = 0
				i   = 0
				while i != @list_type.size
					if @chomp[@i] =~ @list_type[i][0]
						sum = 1
						@token.push([@list_type[i][1],@chomp[@i]])
						break
					end
					i+=1
				end
				if sum != 1
					error("undefined variable or method")
					break
				end
			end
			@i+=1
		end
		return @token
	end

	def error(msg)
		puts "Error: #{@i+1}th token ( #{@chomp[@i]} ): LexerError: #{msg}"
	end
end
