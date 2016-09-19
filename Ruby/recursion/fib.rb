def fib(position)
	fib_array = [0, 1]
	n = 2
	while n <= position
		new_fib = fib_array[-1] + fib_array[-2]
		fib_array << new_fib
		n += 1
	end
	puts fib_array
end

def fib_rec(position)
	if position < 2
		position
	else
		fib_rec(position - 1) + fib_rec(position - 2)
	end
end

def merge(left, right)
    result = []
    while left.size > 0 and right.size > 0
        if left[0] <= right[0]
            result << left[0]
            left = left[1..-1]
        else
            result << right[0]
            right = right[1..-1]    
        end
    end
    if left.size > 0
        result.concat left
    end
    if right.size > 0
        result.concat right
    end
    return result
end

def merge_sort(arr)
    left, right, result = []    
    
    if arr.size <= 1
        return arr
    else
        middle = arr.size / 2
        left = arr[0..middle - 1]
        right = arr[middle..-1]
        left = merge_sort(left)
        right = merge_sort(right)
        if left.last <= right[0]
            left.concat right
            return left
        end
        result = merge(left, right)
        return result
    end
end

arr = [1, 5, 2, 6]
puts merge_sort(arr)
