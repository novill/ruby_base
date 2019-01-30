require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
class Railway
  TRAIN_TYPES = [PassengerTrain, CargoTrain]

  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  # - Создавать станции
  def create_station
    puts 'Введите название новой станции'
    name = gets.chomp
    @stations << Station.new(name)
  end

  # - Создавать поезда
  def create_train
    puts 'Введите тип нового поезда: 0 - пассажирский, 1 - грузовой'
    train_type = TRAIN_TYPES[gets.to_i]
    return unless train_type

    puts 'Введите номер нового поезда'
    @trains << train_type.new(gets.chomp)
  end

  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def create_route
    puts 'Введите через пробел номер начальной и конечной станции'
    print_stations
    start_station, end_station = gets.chomp.split.map { |station_index| stations[station_index.to_i] }
    return if start_station.nil? || end_station.nil? || start_station == end_station

    @routes << Route.new(start_station, end_station)
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
