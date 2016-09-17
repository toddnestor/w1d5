# This implementation of an n-ary tree uses a single-dimensional array to store all the data instead of separate nodes.
# The "node" is really just the index of an item in the array for the purposes of this class.  Return values and argument inputs are done with those indexes.

class NTree
  def initialize(n=2)
    @n = n
    @tree = []
  end

  # do some math to determine the parent index, that allows us to keep everything in a one-dimensional array
  def parent(index)
    parent_index = index / @n
    parent_index -= 1  if index % @n == 0

    return parent_index if parent_index >= 0

    nil
  end

  # do more math to determine the indexes for the children, and only return the items that have values
  # nil is a placeholder in the array so that every item's eight children spots are filled with something
  # meaning that if we didn't do that check we'd get back eight children for everything, some would just be nil
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

  # checks if an item has children, if it does it returns the index of the first nil child spot for that item
  # raises an error if you are trying to get the next_child_index for an item who's children slots are already filled
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

  # this is still a bfs because since everything is stored in an array the index of the first match is doing a bfs, the tree array is the queue, that's the beauty of storing the tree as a single-dimensional array
  def bfs(target)
    @tree.index(target)
  end

  # returns the values for an array of indexes
  def values(arr)
    arr.map {|i| self[i]}
  end

  # returns the values for a path from the root to the input item
  def path(index)
    values(climb(index))
  end

  # returns the indexes for all the items from the input index through it's parents to root.
  def climb(index)
    path = []

    until index.nil?
      path << index
      index = parent(index)
    end

    path.reverse
  end
end
