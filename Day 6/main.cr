# p! contents = File.read("decleration_short.txt")[..-2].split("\n\n")
contents = File.read("decleration.txt")[..-2].split("\n\n")

# Part 1
# parsing
groups = Array(Array(Char)).new
contents.each {|group| groups << group.chars }
groups = groups.map {|group| group.delete('\n'); group = group.uniq; group}

# counting
count = 0
groups.each do |group|
	group.each do |char|
		count += ('a'..'z').any? {|c| c == char} ? 1 : 0
	end
end
p! count

# part 2
# parsing
groups = Array(Array(Array(Char))).new
contents.each do |group|
	strings = Array(Array(Char)).new
	group.split('\n').each do |string|
		strings << string.chars
	end
	groups << strings
end

# counting
total_count = 0
groups.each do |group|
	total_count += intersect group
end
p! total_count

def intersect (crr : Array(Array(Char))) : UInt8
	count = 0
	crr[0].each do |base_char|
		simple_count = 0
		crr.each do |cr|
			simple_count += cr.any? {|c| c == base_char} ? 1 : 0
		end
		count += simple_count == crr.size ? 1 : 0
	end
	UInt8.new count
end
