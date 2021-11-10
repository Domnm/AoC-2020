contents = File.read_lines("boarding.txt")
# contents = File.read_lines("boarding_small.txt")

seat_IDs = [] of UInt16

contents.each { |line| line = parse line; seat_IDs << find_ID line }
seat_IDs = seat_IDs.sort

# first part
p! seat_IDs.last

# second part
p! solution = (seat_IDs.first..seat_IDs.last).to_a - seat_IDs

def find_ID (line : Tuple(Int8, Int8)) : UInt16
	line[0].to_u16*8 + line[1]
end

def parse (s : String) : Tuple(Int8, Int8)
	x = s[..6].chars.map {|c| c = c == 'B' ? '1' : '0'}
	xx = String.new
	x.each { |n| xx += n.to_s }

	y = s[7..].chars.map {|c| c = c == 'R' ? '1' : '0'}
	yy = String.new
	y.each { |n| yy += n.to_s }

	Tuple.new(xx.to_i8(base: 2), yy.to_i8(base: 2))
end
