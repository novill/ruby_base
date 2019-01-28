class Train
  attr_accessor :speed
  attr_reader :carriages_quantity, :number


  def initialize(number, type, carriages_quantity)
    @number = number
    @type = type
    @carriages_quantity = carriages_quantity
    @speed = 0
    @current_station = nil
  end

  def stop
    @speed = 0
  end
  
  def add_carriage
    @carriages_quantity += 1 if speed  == 0
  end 

  def remove_carriage
    @carriages_quantity -= 1 if @carriages_quantity > 0 && speed  == 0
  end 

  def route=(route)
    @route = route
    route.stations[0].get_train(self)
    @current_station = route.stations[0]
  end

  def move_forward
    current_station_index = @route.stations.index(@current_station)
    return if (current_station_index == @route.stations.size - 1)
    @current_station.send_train(self)
    @current_station = @route.stations[current_station_index + 1]
    @current_station.get_train(self)
  end

  def move_backward
    current_station_index = @route.stations.index(@current_station)
    return if (current_station_index == 0)
    @current_station.send_train(self)
    @current_station = @route.stations[current_station_index - 1]
    @current_station.get_train(self)
  end

  def closest_stations
    current_station_index = @route.stations.index(@current_station)
    
    if current_station_index > 0
      puts @route.stations[current_station_index - 1].name
    else 
      puts 'no station before first'
    end
    puts @route.stations[current_station_index].name
    if current_station_index < @route.stations.size - 1
      puts @route.stations[current_station_index + 1].name
    else
     puts 'no station after last'
    end
  end
end
