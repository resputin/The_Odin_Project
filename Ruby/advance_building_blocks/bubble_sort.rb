def bubble_sort(unsorted_array)
	pass = 0
	holding_value = 0
	sorted_array = unsorted_array
	while unsorted_array.length - pass != 0
		i = 0
		while i < sorted_array.length - pass
			if (sorted_array[i] <=> sorted_array[i + 1]) == 1
				holding_value = sorted_array[i]
				sorted_array[i] = sorted_array[i + 1]
				sorted_array[i + 1] = holding_value
				i += 1
			else
				i += 1
			end
		end
		pass += 1
	end
	puts sorted_array
end

def bubble_sort_by(unsorted_array)
	pass = 0
	holding_value = 0
	sorted_array = unsorted_array
	while unsorted_array.length - pass != 0
		i = 0
		while i < sorted_array.length - pass - 1
			value = yield sorted_array[i], sorted_array[i + 1]
			if value >= 1
				holding_value = sorted_array[i]
				sorted_array[i] = sorted_array[i + 1]
				sorted_array[i + 1] = holding_value
				i += 1
			else
				i += 1
			end
		end
		pass += 1
	end
	puts sorted_array
end

bubble_sort([3, 2, 1, 6, 8, 1, 4, 5])

bubble_sort_by(["hi","hello","hey", "yo", "noooooo"]) do |left,right|
	left.length - right.length
end