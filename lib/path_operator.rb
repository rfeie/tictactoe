class PathOperator

	def count_of_non_mark_in_path(path, mark_to_ignore)
		invalid_path_count = 0

		return invalid_path_count if path.any? {|node| node.content == mark_to_ignore}

		path.count do |node|
			node.content
		end
	end		

	def path_empty?(path)
		path.all? { |node| node.content.nil?}
	end

	def get_empty_nodes_in_path(path)
		path.select{ |node| node.content.nil? }
	end

	def find_unmixed_mark(path)
		unmixed_mark_path = get_unmixed_path(path.dup)
		unmixed_mark_path.first
	end

	def count_unmixed_mark(path)
		unmixed_mark_path = get_unmixed_path(path.dup)
		unmixed_mark_path.length
	end

	private

	def get_unmixed_path(path)
		mark = nil
		processed_path = []
		until path.empty?
			node = path.shift			
			content = node.content
			next if content.nil?
			mark ||= content
			if mark != content
				return []
			else
				processed_path << content
			end
		end
		processed_path
	end

end