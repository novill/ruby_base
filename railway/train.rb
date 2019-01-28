class Train
  attr_reader :carriages_quantity, :number

  def initialize(number, type, carriages_quantity)
    @number = number
    @type = type
    @carriages_quantity = carriages_quantity
    @speed = 0
    @current_station_index = nil
  end

  def increase_speed(boost)
    @speed += boost if boost > 0
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages_quantity += 1 if @speed.zero?
  end

  def remove_carriage
    @carriages_quantity -= 1 if @carriages_quantity > 0 && @speed.zero?
  end

  def route=(route)
    @route = route
    route.stations[0].get_train(self)
    @current_station_index = 0

  end

  def move_forward
    return if @current_station_index == @route.stations.size - 1

    @route[@current_station_index].send_train(self)
    @current_station_index += 1
    @route[@current_station_index].get_train(self)
  end

  def move_backward
    return if @current_station_index.zero?

    @route[@current_station_index].send_train(self)
    @current_station_index -= 1
    @route[@current_station_index].get_train(self)
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.size - 1
  end
end
