class GridError < StandardError
  def initialize(msg = 'Grid in wrong format')
    super
  end
end
