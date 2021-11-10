class Array (T)
	def max
		m = self[0]
		self.each { |a| if m < a; m = a; end }
		m
	end

	def min
		m = self[0]
		self.each { |a| if m > a; m = a; end }
		m
	end

	def smallest_pos_dif(n)
		m = 0
		self.each do |a|
			m = a - n
			break if a > n
	 	end

		self.each { |a| m = a - n if a > n && m > a - n}
		m
	end

	def split_by_dif(dif : Number)
		p! self
		ret = [] of UInt32
		first = true; first_i = 0; last_i = 0
		self.each_with_index do |a, i|
			if first
				first = false
				next
			end

			if a - self[i - 1] == 1
				first_i = i - 1
			end

			if a - self[i - 1] != 1
				last_i = i
			end

			p! first_i; p! last_i; p! a; p! i
		end
	end
end

contents = File.read_lines("jolts_short.txt"); DIF = 3; current = 0; add = 0
p! contents = contents.map { |line| line.to_i}
p! contents.smallest_pos_dif current

jolt_dif = [] of UInt16
(0...DIF).each do
	jolt_dif << 0
end

run = true; connections = [] of UInt16
while run
	connections << (current).to_u16
	p! add = contents.smallest_pos_dif current
	# p! contents


	if add <= DIF
		puts " DELETION "; p! current + add
		jolt_dif[add - 1] += 1
	elsif (add > DIF)
		break
	end
	if (contents.size <= 0)
		break
	end

	p! contents.size
	p! contents

	contents.delete(current + add).not_nil!
	current += add

	sleep 0.01
end

p! jolt_dif
p! jolt_dif[0]*jolt_dif[2]
p! current + add + DIF
p! connections

# DOESNT WORK:
# To calculate all posible permutations
# areas where it is possible to remove certain variable must be found
#
# Fore exmaple here:
#      5, 6 and 11 can be removed
# since 5 and 6 are next to each other there are four permutations:
# none, either one or both
#
# Same goes with 11, it can either be or not
#
# Overall there are 4 [5 and 6] * 2 [11] =  8 posible permutations
# [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]

permutations = 1
connections.each_with_index do |c, i|
	# checks
	if i < connections.size - 3 && c == connections[i + 1] - 1 && connections[i + 1] == connections[i + 2] - 1 && connections[i + 2] == connections[i + 3] - 1
		permutations *= 4
	elsif i < connections.size - 2 && c == connections[i + 1] - 1 && connections[i + 1] == connections[i + 2] - 1
		permutations *= 2 if connections[i - 1] != c - 1
	end
end

p! connections
p! permutations
p! connections.split_by_dif DIF

# begin
# 	p!
# rescue
# 	p! contents
# 	p! current + add
# 	p! contents.delete(current + add)
# 	raise ""
# end


# Should split this array into multiple arrays leaving out places where
# they cannot be permutated
# [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]
