class Breadcrumb
  attr_reader :items

  def initialize
    @items = []
  end

  def add(title, path)
    @items << { title: title, path: path }
  end
end
