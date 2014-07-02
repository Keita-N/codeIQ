class Maze
	attr_accessor :symbols, :file_path

	# 指定したファイルを読み込んで各座標の記号を２次元配列で保持
	def initialize(file_path)
		@file_path = file_path
		@symbols = []
		File.open(file_path).each { |line| @symbols << line.chomp.split('')  }
	end

	# 指定の座標の記号を返す
	def symbol(point)
		symbols[point.y][point.x]
	end

	# 指定の座標の隣の記号を返す
	def next_symbol(point, direction)
		next_point = point.next(direction)
		return '' unless next_point.x.between?(0, symbols[0].length - 1)
		return '' unless next_point.y.between?(0, symbols.length - 1)
		symbol(next_point)
	end

	# 隣のマスに移動可能か判定
	def enable_to_move?(point, direction)
		current_symbol = symbol(point)
		next_symbol = next_symbol(point, direction)

		return next_symbol == 'A' if current_symbol == 'C'
		return current_symbol.next == next_symbol
	end

	# 右下角のマスのゴールに到達したか判定
	def goal?(point)
		@goal = Point.new(symbols[0].length - 1, symbols.length - 1)
		@goal == point
	end

	def max
		(symbols[0].length) * (symbols.length) 
	end

end

class Point
	attr_accessor :x, :y
	def initialize(x = 0, y = 0)
		@x = x
		@y = y
	end

	def next(direction)
		send(direction)
	end
	alias :move :next

	def to_s
		"Point(x = #{x}, y = #{y})"
	end

	def ==(other)
		other.x == @x and other.y == @y
	end

	private
	def up
		Point.new(x, y - 1)
	end

	def down
		Point.new(x, y + 1)
	end

	def left
		Point.new(x - 1, y)
	end

	def right
		Point.new(x + 1, y)
	end
end

class Player

	def simulate(maze)
		@maze = maze
		@path = []
		start = Point.new
		@is_possible = false
		check_next_point(start)
		if @is_possible
			puts "#{maze.file_path}: possible"
		else
			puts "#{maze.file_path}: impossible"
		end
	end

	def check_next_point(point, depth=0)
		# 通ったマスをメモ
		@path << point
		[:right, :left, :up, :down].each do |direction|
			if @maze.enable_to_move?(point, direction)
				moved_to = point.move(direction)
				if @maze.goal?(moved_to)
					@is_possible = true
				elsif @path.include?(moved_to)
					# 一度通ったマス目を通ったらループと判断する。
					next
				elsif @path.length > @maze.max
					# マス目の数以上動く場合はループに陥ったと判断する	
					next
				else
					check_next_point(moved_to, depth+=1)
				end
			end
		end
	end

end

player = Player.new

player.simulate(Maze.new("case1.in.txt"))
player.simulate(Maze.new("case2.in.txt"))
player.simulate(Maze.new("case3.in.txt"))
player.simulate(Maze.new("case4.in.txt"))
player.simulate(Maze.new("case5.in.txt"))
player.simulate(Maze.new("case6.in.txt"))
player.simulate(Maze.new("case7.in.txt"))
