
class SquareBox
	def initialize(height)
		@height = height
	end

	def width(radius, num)
		2 * radius * num 
	end

	def height
		@height
	end

	def length(radius, num)
		2 * radius * num 
	end

	def volume(beer_can, num)
		r = beer_can.radius
		width(r, num) * length(r, num) * height / (10 ** 3)
	end
end

class GoodBox
	def initialize(height)
		@height = height
	end

	def height
		@height
	end

	def width(radius, num)
		Math.sqrt(3) * radius * (num - 1) + 2 * radius
	end

	def length(radius, num)
		len = 2 * radius * num
		len += radius if num > 1
		len
	end

	def volume(beer_can, num)
		r = beer_can.radius
		width(r, num) * length(r, num) * height / 10 ** 3
	end

end

class BeerCan

	def initialize(r)
		@radius = r
	end

	def radius
		@radius
	end

end

BEER_RADIUS = 32
BOX_HEIGHT = 120
beer_can = BeerCan.new(BEER_RADIUS)
old_box = SquareBox.new(BOX_HEIGHT)
new_box = GoodBox.new(BOX_HEIGHT)

(1...10).each do |i|
	puts "case:#{i}"
	puts "old:#{old_box.volume(beer_can, i)}"
	puts "new:#{new_box.volume(beer_can, i)}"
	puts "-----------"
end

i = 1
loop do
	old_box_volume = old_box.volume(beer_can, i)
	new_box_volume = new_box.volume(beer_can, i)

	if old_box_volume > new_box_volume
		puts "answer:  when n >= #{i}, new way is better than older. "
		break
	end
	i += 1
end