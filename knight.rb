require_relative 'treenode'
require 'set'

class KnightPathFinder

  OFFSETS = [[2,1],[2,-1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]

  def self.valid_moves(pos)
    #returns list of valid positions knight can reach from current position
    row, col = pos
    valid_moves = []
    OFFSETS.each do |offset|
      d_x, d_y = offset
      new_pos = [row + d_x, col + d_y]
      valid_moves << new_pos if new_pos.all? { |num| num.between?(0,8) }
    end
    return valid_moves
  end

  def new_move_positions(pos)
    valid_moves = self.class.valid_moves(pos)
    valid_moves.reject { |pos| @visited_pos.include?(pos) }
  end

  def initialize(pos)
    @pos = pos
    @visited_pos = Set.new
    @root = PolyTreeNode.new(pos)
    @visited_pos.add(pos)
    @tree = Set.new
    build_move_tree
  end

  def build_move_tree
    #builds poly node tree of unique possible positions
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      children_pos = new_move_positions(current_pos)
      children_pos.each do |child_pos|
        child_node = PolyTreeNode.new(child_pos)
        child_node.parent = current_node
        @tree << child_node
        @visited_pos << child_pos
        @queue += child_node
      end
    end
  end

  def find_path
    #use DFS or BFS to find path to target leaf
  end
  def trace_back_path
    #trace back pointers to beginning and reverse list
  end
end
