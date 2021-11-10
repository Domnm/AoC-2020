enum Opp_code
	Acc
	Jmp
	Nop
	Err # error things
end

struct Instruction
	property opp_code, arg
	def initialize(@arg : Int16, @opp_code = Opp_code::Err); end
	def clone; self; end;
end

code = File.read_lines("code.txt")

# parsing
code = code.map do |loc|
	loc = loc.split(' ')
	loc = Instruction.new loc[1].to_i16, Opp_code.parse(loc[0])
end

# remove these variables and until program_ended loop to revert back to part one since it's basically just bruteforcing a solution
program_ended = false
original_code = code.clone

changed_loc = 0
until program_ended
	code = original_code.clone
	while code[changed_loc].opp_code != Opp_code::Jmp
		changed_loc += 1
	end

	code[changed_loc] = Instruction.new code[changed_loc].arg, Opp_code::Nop
	# code[changed_loc].opp_code = Opp_code::Nop  is the same as above but is adapted for struts instead of classes
	changed_loc += 1

	accumulator = 0
	counter = 0 # shows witch instruction do execute
	tracker = Array.new code.size, 0 # counts how many times individual instructions have been executed

	while tracker.all? { |tr| tr < 2 }

		if counter >= code.size; program_ended = true; break; end;
		break if tracker[counter] == 1

		tracker[counter] += 1

		case code[counter].opp_code
		when Opp_code::Nop
			counter += 1
		when Opp_code::Acc
			accumulator += code[counter].arg
			counter += 1
		when Opp_code::Jmp
			counter += code[counter].arg
		end
	end
end

p! accumulator
