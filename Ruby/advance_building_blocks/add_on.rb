module Enumerable
	def my_each
		for i in self
			yield i
		end       
	end

	def my_each_with_index
		for i in 0..length
			yield(self[i] , i)
		end 
	end

	def my_select
		new_array = []
		my_each { |i| new_array << i if yield(i)}
		new_array
	end

	def my_all?
		last = true
		for i in self
			if !yield(i)
				last = false
				break
			end
		end
		last
	end

	def my_any?
		last = false
		for i in self
			if yield(i)
				last = true
				break
			end
		end
		last
	end

	def my_none?
		last = false
		for i in self
			if !yield(i)
				last = true
			else
				last = false
				break
			end
		end
		last
	end

	def my_count?
		count = 0
			for i in self
				if yield(i)
					count += 1 
				end
			end
		count
	end

	def my_map(block)
		if block
			new_array = []
			my_each { |i| new_array << block.call(i) }
			new_array
		else
			return self
		end
	end

	def my_inject(num = nil)
		accumulator = num.nil? ? first : num
		my_each { |i| accumulator = yield(accumulator, i) }
		accumulator
	end

	def multiply_els(list)
		list.my_inject(1) { |product, i| product * i }
	end

end

ary = [3, 4, 4, 3]
ary.my_map do |i|
   i * 3
end
