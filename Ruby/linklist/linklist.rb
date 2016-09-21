class LinkedList

	def initialize
		@head = nil
		@tail = nil
	end

		def append(value)
			new_node = Node.new(value)
			if @head.nil?
				@head = new_node
				@tail = new_node
			else
				pos = @head
				until pos.next_node.nil?
					pos = pos.next_node
				end
				pos.next_node = new_node
				@tail = new_node
			end
		end

		def prepend(value)
			new_node = Node.new(value)
			if @head.nil?
				@head = new_node
				@tail = new_node
			else
				new_node.next_node = @head
				@head = new_node
			end
		end

		def size
			pos = @head
			counter = 1
			until pos.next_node.nil?
				pos = pos.next_node
				counter += 1
			end
			counter
		end

		def head
			@head.value
		end

		def tail
			@tail.value
		end

		def at(index)
			if index == 0
				return @head.value
			else
				counter = 0
				pos = @head
				until counter == index
					pos = pos.next_node
					counter += 1
				end
				return pos.value
			end
		end

		def pop
			pos = @head
			until pos.next_node.nil?
				prev_pos = pos
				pos = pos.next_node				
			end
			@tail = prev_pos
			@tail.next_node = nil
			pos = nil
		end

		def contains?(value)
			pos = @head
			until pos.nil?
				if pos.value == value
					return true
				end
				pos = pos.next_node
			end
			return false
		end

		def find(value)
			counter = 0
			pos = @head
			until pos.nil?
				if pos.value == value
					return counter
				end
				pos = pos.next_node
				counter += 1
			end
			return nil
		end

		def to_s
			pos = @head
			string_value = ""
			until pos.nil?
				string_value = string_value + "( #{pos.value} ) -> "
				pos = pos.next_node
			end
			string_value = string_value + "nil"
			string_value
		end

		def insert_at(index, value)
			counter = 0
			pos = @head
			new_node = Node.new(value)
			until counter == index - 1
				pos = pos.next_node
				counter += 1
			end
			new_node.next_node = pos.next_node
			pos.next_node = new_node
		end

		def remove_at(index)
			counter = 0
			pos = @head
			if index == 0
				@head = pos.next_node
			else
				until counter == index - 1
					pos = pos.next_node
					counter += 1
				end
				temp_pos = pos.next_node
				pos.next_node = pos.next_node.next_node
				temp_pos = nil
			end
		end
end

class Node
	
	attr_accessor :next_node, :value
	def initialize(value)
		@value = value
		@next_node = nil
	end
end

ll = LinkedList.new
ll.append(1)
ll.prepend(2)
ll.insert_at(1, 5)
ll.remove_at(0)
puts ll.to_s