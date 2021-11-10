contents = File.read_lines("passwords.txt")

valid = 0

contents.each do |line|
	line = line.split '-'
	p! min = line[0].to_i
	line = line[1]

	line = line.split(' ')
	p! max = line[0].to_i
	char = line[1]; p! char = char[0]
	p! pass = line[2]

	i = 0
	count = 0
	while i < pass.size
		if p! pass[i] == char
			count += 1
		end
		i += 1
	end

	p! count

	if p! (count >= min && count <= max)
		valid += 1
	end
	p! valid
end

puts "VALID: " + valid.to_s
