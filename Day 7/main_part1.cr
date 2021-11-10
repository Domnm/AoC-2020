class Top_level_bag
	property color_name, bags_inside
	def initialize(@color_name : String, @bags_inside : Array(Contained_bag) = Array(Contained_bag).new); end

	#checks if top level bag has a bag with a specified color
	def has? (color_name : String) : Bool
		has = false
		@bags_inside.each do |bag|
			if bag.color_name == color_name
				has = true
				break has
			end
		end
		has
	end

	def has? (color_names : Array(String)) : Bool
		has = false
		color_names.each do |color_name|
			@bags_inside.each do |bag|
				if bag.color_name == color_name
					has = true
					break has
				end
			end
			if has; break; end
		end
		has
	end
end


struct Contained_bag
	property color_name, item_count
	def initialize(@color_name : String, @item_count : UInt8);	end
end

COLOR = "shiny gold"
contents = File.read_lines("bags.txt")

# parsing
top_bags = [] of Top_level_bag
contents.each do |content|
	content = content.split(' ')
	color_name = content[0] + " " + content[1]
	content.delete_at(0..3)

	# checks if no other bags inside are needed
	if content[0] == "no"
		top_bags << Top_level_bag.new (color_name)
	# adds bags needed into an array
	else
		bags = [] of Contained_bag
		loop_count = (content.size / 4).to_i; i = 0
		while i < loop_count
			bags << Contained_bag.new content[1] + " " + content[2], content[0].to_u8
			i += 1
			content.delete_at(0..3)
		end
		top_bags << Top_level_bag.new color_name, bags
	end
end

p! top_bags.size
pp! top_bags

count = 0; total_bags = 0; i = 0
needed_colors = [] of String
top_bags = top_bags.map do |top_bag|
	if top_bag.has? COLOR
		# total_bags +=
		count += 1
		needed_colors << top_bag.color_name
		top_bag = Top_level_bag.new "Empty color"
		i -= 1
	end
	i += 1
	top_bag
end

(1..contents.size).each do
	need_colors = [] of String
	top_bags = top_bags.map do |top_bag|
		if top_bag.has? needed_colors
			count += 1
			need_colors << top_bag.color_name
			top_bag = Top_level_bag.new "Empty color"
			i -= 1
		end
		i += 1
		top_bag
	end
	needed_colors = need_colors
end

pp! top_bags
p! count

# needed_colors.each do |needed_color|
# 	top_bags = top_bags.map do |top_bag|
# 		if top_bag.has? needed_color
# 			count += 1
# 			needed_colors << top_bag.color_name
# 			i -= 1
# 		end
# 		i += 1
# 		top_bag
# 	end
# end


#
# puts
# puts "HAS NEEDED COLOR                                              AAAAAAAAAAA"
# p! needed_colors
# puts count
#
# # (1..contents.size).each do
# (1..3).each do
#
#
# end
#
# puts
# puts "HAS NEEDED COLOR                       AAAAAAAAAAA"
# p! needed_colors
# puts i
