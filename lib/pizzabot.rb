require_relative 'pizzabot/route_service'

class Pizzabot
  NO_ARGUMENT_MESSAGE = 'You should provide delivery string to pizzabot,'\
                        ' example: pizzabot "2x2 (0,1) (0,2)"'
  INITIAL_POSITION = [0, 0]

  attr_reader :route
  attr_accessor :current_position, :delivery_process

  def initialize(delivery_string)
    raise ArgumentError, NO_ARGUMENT_MESSAGE unless delivery_string

    @current_position = INITIAL_POSITION
    @delivery_process = ''
    @route = RouteService.new(delivery_string).prepare_route
  end

  def deliver
    route.each do |address|
      move_to(address)
      drop_pizza
    end

    puts delivery_process
    delivery_process
  end

  private

  def move_to(address)
    current_position[0] < address[0] ? move_east : move_west until current_position[0] == address[0]

    current_position[1] < address[1] ? move_north : move_south until current_position[1] == address[1]
  end

  def drop_pizza
    delivery_process << 'D'
  end

  def move_north
    current_position[1] += 1
    delivery_process << 'N'
  end

  def move_south
    current_position[1] -= 1
    delivery_process << 'S'
  end

  def move_west
    current_position[0] -= 1
    delivery_process << 'W'
  end

  def move_east
    current_position[0] += 1
    delivery_process << 'E'
  end
end
