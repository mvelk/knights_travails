
class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
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
    unless new_parent == @parent
      @parent.children.delete(self) if @parent
      @parent = new_parent
      @parent.children << self unless new_parent.nil? || @parent.children.include?(self)
    end
  end

  def has_child?(child)
    @children.include?(child)
  end

  def add_child(child)
    unless has_child?(child)
      @children << child
      child.parent = self
    end
  end

  def remove_child(child)
    raise "Child does not exist" unless self.has_child?(child)
    child.parent = nil
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
      current_node = queue.shift
      return current_node if current_node.value == target
      queue += current_node.children
    end
    nil
  end
end
