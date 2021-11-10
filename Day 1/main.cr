contents = File.read_lines("numbers.txt")

numbers = [] of Int32
contents.each do |number|
	numbers << number.to_i
end

puts "TWO NUMBERS: "
numbers.each do |number|
	i = 1
	while i < numbers.size
		if number + numbers[i] == 2020
			puts "FOUDN IT: " + number.to_s + " " + numbers[i].to_s
			puts "THE ANSWER: " + (number*numbers[i]).to_s
		end
		i += 1
	end
end

puts "\n THREE NUMBERS: "
numbers.each do |number|
	i = 1
	while i < numbers.size
		j = 2
		while j < numbers.size
			if number + numbers[i] + numbers[j] == 2020
				puts "FOUDN IT: " + number.to_s + " " + numbers[i].to_s + " " + numbers[j].to_s
				puts "THE ANSWER: " + (number*numbers[i]*numbers[j]).to_s
			end
			j += 1
		end
		i += 1
	end
end
