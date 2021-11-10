# contents = File.read("passports_short_cor.txt").split("\n\n")
# contents = File.read("passports_short_inc.txt").split("\n\n")
contents = File.read("passports.txt").split("\n\n")
Valid_requirements = ["ecl", "pid", "eyr", "hcl", "byr", "iyr","hgt"]
Valid_ecl = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

passports = [] of Hash(UInt16 | String | Nil, UInt16 | String | Nil) | Hash(String, UInt16 | String)

## Checks every passport
contents.each do |passport|
	info = passport.split
	parsed_details = Hash(String, String | UInt16).new

	## checks one bit of information on that passport
	info.each do |detail|
		details = [] of UInt16 | String | Nil
		details << detail.split(':')[0]
		details << detail.split(':')[1].to_i?

		if details[1].class == Nil || details[0] == "hcl" || details[0] == "pid"
			details[1] = detail.split(':')[1]
		end

		parsed_details = parsed_details.merge Hash{details[0] => details[1]}
	end
	passports << parsed_details
end

valid_passports : UInt16 = 0

## goes through each passport
passports.each do |passport|
	pp! passport
	valid = true

	## checks if a passport has a all needed fields i.e. is valid
	Valid_requirements.each do |valid_requirement|
		if !passport.has_key? valid_requirement
			puts "Not all required fields are present"
			valid = false
			break
		end
	end

	### checks if all fields meet needed requirements / part two
	## checks birth year
	if valid
		if !(1920 <= passport["byr"].as(Number) <= 2002)
			puts "wrong byr"
			valid = false
		## checks issue year
		elsif !(2010 <= passport["iyr"].as(Number) <= 2020)
			puts "wrong iyr"
			valid = false
		## checks expiration year
		elsif !(2020 <= passport["eyr"].as(Number) <= 2030)
			puts "wrong eyr"
			valid = false
		## checks height
		elsif passport["hgt"].class == UInt16
			puts %("hgt lacks "cm" or "in)
			valid = false
		elsif passport["hgt"].as(String)[-2..] == "cm" && !(150 <= passport["hgt"].to_s[..-3].to_i <= 193)
			puts "Height: is bad in cm"
			valid = false
		elsif passport["hgt"].as(String)[-2..] == "in" && !(59 <= passport["hgt"].to_s[..-3].to_i <= 76)
			puts "Height: is bad in in"
			valid = false
		## checks hair color
		elsif (passport["hcl"].as(String)[0] != '#')
			puts "Hair color: doenst start with \"#\""
			valid = false
		elsif (passport["hcl"].as(String).size != 7)
			puts "Hair color: not six characters"
			valid = false
		elsif !passport["hcl"].as(String)[1..].each_char.all? {|char| ('a'..'f').any? {|rule| rule == char} || ('0'..'9').any? {|rule| rule == char}}
			puts "Hair color: not 0..9 or a..f"
			valid = false
		## checks eye color
		elsif !(Valid_ecl.any? {|color| color == passport["ecl"]})
			puts "Eye color: no match"
			valid = false
		## checks passport id
		elsif (passport["pid"].as(String).size != 9 || passport["pid"].as(String).to_i? == Nil)
			puts "Pid is not 9 digits or has not digits"
			valid = false
		end
	end

	if valid
		valid_passports += 1
	end
end

p! valid_passports
