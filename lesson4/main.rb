require_relative 'carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'railway.rb'

# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
# - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции

puts 'Управление железной дорогой'
@railway = Railway.new

def create_station_action
  puts 'Введите название новой станции'
  name = gets.chomp
  @railway.add_station(Station.new(name))
end

def create_train_action
  puts 'Введите тип нового поезда: 1 - пассажирский, что-то другое - грузовой'
  type = gets.to_i
  puts 'Введите номер нового поезда'
  number = gets.chomp
  if type == 1
    @railway.add_train(PassengerTrain.new(number))
  else
    @railway.add_train(CargoTrain.new(number))
  end
end

def create_route_action
  puts 'Введите через пробел номер начальной и конечной станции'
  @railway.print_stations
  start_station, end_station = gets.chomp.split.map { |station_index| @railway.stations[station_index.to_i] }
  @railway.add_route(Route.new(start_station, end_station))
end

def select_route_action
  puts 'Введите номер маршрута'
  @railway.print_routes
  @railway.routes[gets.to_i]
end

def add_route_station_action
  route = select_route_action
  puts 'Введите номер добавляемой станции'
  @railway.print_stations
  route.add_station(@railway.stations[gets.to_i])
end

def remove_route_station_action
  route = select_route_action
  puts 'Введите номер удаляемой станции'
  route.print_stations
  route.remove_station(route.stations[gets.to_i])
end

def manage_routes_menu
  loop do
    puts 'Выберите действие:'
    puts '1. Создать маршрут'
    puts '2. Добавить станцию к маршруту'
    puts '3. Удалить станцию из маршрута'
    puts '0. Выход'
    case gets.to_i
    when 0 then return
    when 1 then create_route_action
    when 2 then add_route_station_action
    when 3 then remove_route_station_action
    end
  end
end

def select_train_action
  puts 'Введите номер поезда в списке'
  @railway.print_trains
  @railway.trains[gets.to_i]
end

def set_train_to_route_action
  select_train_action.route = select_route_action
end

def add_carriage_action
  puts 'Введите тип нового вагона: 1 - пассажирский, что-то другое - грузовой'
  type = gets.to_i
  carriage = type == 1 ? PassengerCarriage.new : CargoCarriage.new
  select_train_action.add_carriage(carriage)
end

def remove_carriage_action
  select_train_action.remove_carriage
end

def move_trains_action
  train = select_train_action
  puts 'Выберите действие:'
  puts '1. Переместить по маршруту вперед'
  puts '2. Переместить по маршруту назад'
  case gets.to_i
  when 1 then train.move_forward
  when 2 then train.move_backward
  end
end

def print_stations_action
  puts 'Выберите действие:'
  puts '1. Посмотреть список станций'
  puts '2. Посмотреть список поездов на станции'
  case gets.to_i
  when 1 then @railway.print_stations
  when 2 then
    puts 'Введите номер станции'
    @railway.print_stations
    @railway.stations[gets.to_i].print_trains
  end
end

loop do
  puts 'Выберите действие:'
  puts '1. Создать станции'
  puts '2. Создать поезда'
  puts '3. Создать маршруты и управлять станциями в нем (добавить, удалить)'
  puts '4. Назначить маршрут поезду'
  puts '5. Добавить вагоны к поезду'
  puts '6. Отцепить вагоны от поезда'
  puts '7. Переместить поезд по маршруту вперед или назад'
  puts '8. Просмотреть список станций или список поездов на станции'
  puts '0. Закончить программу'

  case gets.to_i
  when 0 then exit
  when 1 then create_station_action
  when 2 then create_train_action
  when 3 then manage_routes_menu
  when 4 then set_train_to_route_action
  when 5 then add_carriage_action
  when 6 then remove_carriage_action
  when 7 then move_trains_action
  when 8 then print_stations_action
  end
end
