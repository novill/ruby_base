class Railway
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  # - Создавать станции
  def add_station(station)
    @stations << station
  end

  # - Создавать поезда
  def add_train(train)
    @trains << train
  end

  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def add_route(route)
    @routes << route
  end

  # - Просматривать список станций
  def print_stations
    puts 'Список станций:'
    stations.each_with_index { |station, index| puts "#{index}. #{station}" }
  end

  def print_trains
    puts 'Список поездов:'
    trains.each_with_index { |train, index| puts "#{index}. #{train}" }
  end

  def print_routes
    puts 'Список маршрутов:'
    routes.each_with_index do |route, index|
      puts index
      route.print_stations
    end
  end
end
