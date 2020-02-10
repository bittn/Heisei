class Runner
	def initialize(tkn)
		@token = tkn
		@var   = {}
		@line  = 1
		@PktMth = []
	end

	def run(ss,ff)
		pp = ss # sも処理される。fも処理される。
		while true
			case @token[pp][0]
			when "PRINT" #PRINT
				pp+=1
				# byebug
				puts getVar(@token[pp][1])
			when "VAR" # VAR EQUAL
				# byebug
				pp+=1
				if @token[pp][0] == "EQUAL"
					pp+=1
					@var[@token[pp-2][1]] = getVar(@token[pp][1])
				else
					rerror(1,pp)
					break
				end
			when "<BR>"
				@line+=1
			# Please write your new method here.
			#when "Token_Name"
			#  Your Method Movement
			else
				rerror(4,pp)
				break
			end
			pp+=1

			if @token[pp] == nil || pp==ff+1
				# byebug
				break
			end
		end
	end

	def rerror(n,pp)
		puts "Error: #{@line}:#{pp.to_i+1}th ( #{@token[pp.to_i]} ): RunnerError, (Point: #{n})"
	end


	def getValue(e)
		exp = e.split(/(\+|-)/)

		if exp[0] == ""
			exp.delete_at(0)
		end

		i=0
		type="start"
		acc=0
		while i != exp.size
			if exp[i] == "+" && type != "opr"
				type = "opr"
			elsif exp[i] == "-" && type != "opr"
				type = "opr"
			elsif exp[i] =~ /\d+/ && type != "value" && type != "var"
				type = "value"
			elsif exp[i] =~ /\w+/ && type != "var" && type != "value"
				type = "var"
				exp[i] = getVar(exp[i])
			else
			end
			i+=1
		end

		if exp[0] != "+" && exp[0] != "-"
			exp.unshift("+")
		end

		i=0
		while i != exp.size
			if exp[i] == "+"
				i+=1
				acc += exp[i].to_i
			elsif exp[i] == "-"
				i+=1
				acc -= exp[i].to_i
			end
			i+=1
		end
		return acc
	end

	def getVar(c)
		case c
		when "PktAnl_new"
				return eval(`cat ~/.pinenut/.pa_text.txt`)
		when /"(.+)"/
			return $1.gsub("\\n","\n")
		when /[0-9\.]+/
			return c.to_i
		when /(\w+)\[(\d+)\]/
			return getvar(@var[$1][$2.to_i])
		when /.+/ # 最後
			return @var[c]
		else
			rerror(6,p)
		end
	end
end
