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
    @parent = new_parent
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end


end
