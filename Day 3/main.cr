require "option_parser"

contents = File.read_lines("field_small.txt")

# First part / Default values
move_x = 3
move_y = 1

# Second part / custom values from user input
OptionParser.parse do |parser|
	parser.on "-y Y", "--y Y" do |y|
		move_y = y.to_i
	end

	parser.on "-x X", "--x X" do |x|
		move_x = x.to_i
	end
end

#p! move_x
#p! move_y

total_x = contents[0].size
total_y = contents.size

contents.map! { |line|
	line * (((total_y / total_x)*move_x).to_i + 1)
}

pos_x = 0
pos_y = 0

count = 0
until pos_y >= contents.size
	# p! pos_y
	# p! pos_x
	# p! contents[pos_y].size
	if contents[pos_y][pos_x] == '#'
		count +=1
	end
	pos_x += move_x
	pos_y += move_y
end

puts "TREES HIT: " + count.to_s
