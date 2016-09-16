class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @children = []
    @parent = nil
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless self.parent.nil?

    @parent = new_parent
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise if child_node.parent.nil?
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      next_item = queue.shift
      return next_item if next_item.value == target
      queue += next_item.children
    end

    nil
  end



end
