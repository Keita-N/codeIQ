class PriceList

	def initialize(price_set)
		# 0個のケースからの買い取り価格表
		@price_set = price_set
	end

	def set_price(set)
		return 0 if set < 0 or set > 10
		@price_set[set]
	end

	def price_per_one(set)
		return 0 if set < 0 or set > 10 
		Float(set_price(set)) / set
	end

	# 所持数内で最も買い取り単価が高いセット数
	def best_efficent_set(own_num)
		best = 0
		num = 0
		(0..own_num).each do |i|
			if best < price_per_one(i)
				best = price_per_one(i)
				num = i
			end
		end
		num
	end

	# 買い取り単価が高いセット数で優先的に売却する
	def best_order(own_number)
		order = []

		loop {
			best_set = best_efficent_set(own_number)
			order << best_set
			own_number -= best_set
			break if own_number == 0
		 }
		 order
	end

	# 合計買取価格
	def sum_of_price(order)
		order.inject(0) {|sum, i| sum += set_price(i)}
	end
end

list = PriceList.new([0, 1, 6, 8 ,10, 17, 18, 20, 24, 26, 30])

own_number = 10
order = list.best_order(10)

puts "set=#{order.join('+')}"
puts "price=#{order.map {|i| list.set_price(i) }.join('+')}=#{list.sum_of_price(order)}"
