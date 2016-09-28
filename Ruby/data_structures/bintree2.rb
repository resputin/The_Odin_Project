class Node
	attr_accessor :parent, :l_child, :r_child, :value

	def initialize(value)
		@value = value
	end

end

def array_to_n(value_array)
		unique = value_array.uniq
		node_array = []
		unique.each { |e| node_array << Node.new(e) }
		node_array
end 

class BinaryTree
	attr_reader :root_node

	def initialize()
		@root_node = nil
	end

	def build_tree(node_array)
		@root_node = node_array[0]
		position = @root_node
		counter = 1
		while counter < node_array.size
			compare = (position.value <=> node_array[counter].value)
			case compare
			when 1
				position.l_child = node_array[counter]
				node_array[counter].parent = position
				position = position.l_child
			when - 1
				position.r_child = node_array[counter]
				node_array[counter].parent = position
				position = position.r_child
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
			unless pos.l_child.nil? then discovery << pos.l_child end
			unless pos.r_child.nil? then discovery << pos.r_child end
			check_node = discovery.shift
			check_value = check_node.value
			if check_value == value
				return check_node
			end
			pos = check_node
		end		
	end

	def dfs(value)
		if @root_node.value == value
			return @root_node
		end
		pos = @root_node
		discovery = []
		discovery << pos
		until discovery.nil?
			unless pos.l_child.nil? then discovery << pos.l_child end
			if pos.l_child.nil? && !pos.r_child.nil? then discovery << pos.r_child end
			check_node = discovery.pop
			check_value = check_node.value
			if check_value == value
				return check_node
			end
			pos = check_node
		end
	end

	def dfs_rec(value, root)
		if root.nil?
			return
		end
		if root.value == value
			return root
		end
		left = dfs_rec(value, root.l_child)
		right = dfs_rec(value, root.r_child)
		left or right
	end
end


node_array = array_to_n([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
bt = BinaryTree.new
bt.build_tree(node_array)
puts bt.bfs(9)
puts bt.dfs_rec(9, bt.root_node)
puts bt.dfs(9)
