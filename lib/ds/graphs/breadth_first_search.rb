# Class implements Breadth First Search in graphs
class BreadthFirstSearch
  attr_accessor :graph, :colors, :parents, :visited, :distance, :to_visit

  def initialize(graph)
    @graph = graph
    @colors = {}
    @parents = {}
    @visited = []
    @distance = {}
    @to_visit = SimpleQueue.new
  end

  def search(s)
    reset!
    visit_source(s)
    until to_visit.empty?
      v = to_visit.dequeue
      visit_neighbors(v)
      colors[v] = :black
      visited << v
    end
    visited
  end

  private

  def reset!
    graph.each_vertex do |v|
      colors[v] = :white
      parents[v] = nil
      distance[v] = Float::INFINITY
    end
  end

  def visit_source(s)
    colors[s] = :white
    parents[s] = nil
    distance[s] = 0
    to_visit.enqueue s
  end

  def visit_node(v, from)
    colors[v] = :grey
    parents[v] = from
    distance[v] = distance[from] + 1
    to_visit.enqueue v
  end

  def visit_neighbors(u)
    graph.neighbors(u).each do |v|
      visit_node(v, u) if not_visited?(v)
    end
  end

  def not_visited?(v)
    colors[v] == :white
  end
end
