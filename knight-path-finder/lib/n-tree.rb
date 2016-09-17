class NTree
  def initialize(n=2)
    @n = n
    @tree = []
  end

  def parent(index)
    parent_index = index / @n
    parent_index -= 1  if index % @n == 0

    return parent_index if parent_index >= 0

    nil
  end

  def children(index)
    child_items = []

    1.upto(@n) do |i|
      child_index = index * @n + i
      child_items << child_index if self[child_index]
    end

    child_items
  end

  def value(index)
    @tree[index]
  end

  def []=(index, value)
    @tree[index] = value
  end

  def [](index)
    @tree[index]
  end

  def include?(value)
    @tree.include?(value)
  end

  def add(item, parent_index=nil)
    if parent_index
      index = next_child_index(parent_index)
    else
      index = 0
    end
    self[index] = item
    index
  end

  def next_child_index(index)
    children_qty = children(index).length
    raise "You violated the maximum #{@n} children for a single node" if children_qty >= @n
    (index * @n) + 1 + children_qty
  end

  def dfs(target, start_index = 0)
    return start_index if self[start_index] == target

    children(start_index).each do |child_index|
      result = dfs(target, child_index)
      return result if result
    end

    nil
  end

  def bfs(target)
    @tree.index(target)
    # @tree.each_with_index do |val, i|     # this looks more bfs-ey, but really we just need the index of the first match, so I did it that way
    #   return i if val == target
    # end
    #
    # nil
  end

  def values(arr)
    arr.map {|i| self[i]}
  end

  def path(index)
    values(climb(index))
  end

  def climb(index)
    path = []

    until index.nil?
      path << index
      index = parent(index)
    end

    path.reverse
  end
end
