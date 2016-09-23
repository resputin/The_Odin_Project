class Node

	attr_accessor :parent, :left_child, :right_child, :value

	def initialize(value)
		@value = value
	end

end

class BinaryTree

	def initialize()
		@root_node = nil
	end

	def build_tree(sorted_data)
		@root_node = Node.new(sorted_data[0])

		pos = @root_node
		counter = 1
		while counter < sorted_data.size - 2
			
			cand1 = sorted_data[counter]
			cand2 = sorted_data[counter + 1]
			if cand1 < pos.value
				pos.left_child = Node.new(cand1)
				pos.left_child.parent = pos
			elsif cand1 > pos.value
				pos.right_child = Node.new(cand1)
				pos.right_child.parent = pos
			end

			if cand2 < pos.value and pos.left_child.nil?
				pos.left_child = Node.new(cand2)
				pos.left_child.parent = pos
				counter += 1
			elsif cand2 > pos.value and pos.right_child.nil?
				pos.right_child = Node.new(cand2)
				pos.right_child.parent = pos
				counter += 1
			end

			if !pos.left_child.nil?
				pos = pos.left_child
			elsif !pos.right_child.nil?
				pos = pos.right_child
			end

			counter += 1
		end
	end

	def bfs(value)
		if @root_node.value == value
			return @root_node
		end
		pos = @root_node
		discovery = []
		discovery << pos
		until discovery.nil?
			unless pos.left_child.nil? then discovery << pos.left_child end
			unless pos.right_child.nil? then discovery << pos.right_child end
			check_node = discovery.shift
			check_value = check_node.value
			puts check_value
			if check_value == value
				return check_node
			end
			pos = check_node
		end		
	end
end


bt = BinaryTree.new()
bt.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts bt.bfs(324).value