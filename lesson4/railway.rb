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
    puts 'Введите тип нового поезда: 1 - пассажирский, 2 - грузовой'
    train_type = TRAIN_TYPES[gets.to_i - 1]
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
    print_array(stations)
  end

  def print_trains
    puts 'Список поездов:'
    print_array(trains)
  end

  def print_routes
    puts 'Список маршрутов:'
    print_array(routes)
  end

  private

  def  print_array(array)
    array.each_with_index { |object, index| puts "#{index}. #{object}" }
  end
end
