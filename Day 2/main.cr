contents = File.read_lines("passwords.txt")

valid = 0

contents.each do |line|
	# parsing
	line = line.split '-'
	p! min = line[0].to_i
	line = line[1]

	#still parsing
	line = line.split(' ')
	p! max = line[0].to_i
	char = line[1]; p! char = char[0]
	p! pass = line[2]

	count = 0
	if pass[min - 1] == char
		count += 1
	end

	if pass[max - 1] == char
		count += 1
	end

	p! count

	if p! (count == 1)
		valid += 1
	end
	p! valid
end

puts "VALID: " + valid.to_s
