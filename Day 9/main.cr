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

end

contents = File.read_lines("numbers.txt"); PREAMBLE = 25
# contents = File.read_lines("numbers_short.txt"); PREAMBLE = 5
p! contents = contents.map { |line| line.to_i64 }

# First part
ii = PREAMBLE
found_nunber = false
while (!found_nunber || ii >= contents.size)
	sums = Set(Int64).new
	jj = ii - PREAMBLE

	# finds add posible additions of last numbers in the range defined in PREAMBLE
	while jj < ii
		kk = jj + 1
		while kk < ii
			sums.add contents[jj] + contents[kk]
			kk += 1
		end
		jj += 1
	end

	found_nunber = true unless sums.any? { |sum| sum == contents[ii]}
	number = contents[ii]
	ii += 1
	# sleep 0.1
end

p! number

# second part
ii = 0; sum = 0
while ii < contents.size && sum != number
	jj = ii
	sum = 0; sums = [] of Int64
	while sum < number.not_nil! && jj < contents.size
		sum += contents[jj]; sums << contents[jj]
		jj += 1
	end
	p! sum; p! sums.max; p! sums.min; p sums.min + sums.max
	ii += 1
end
