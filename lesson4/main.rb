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

class Main
  def initialize
    @railway = Railway.new
  end

  def run
    puts 'Управление железной дорогой'
    loop do
      show_menu(MAIN_MENU)
      case gets.to_i
      when 0 then exit
      when 1 then @railway.create_station
      when 2 then @railway.create_train
      when 3 then manage_routes_menu
      when 4 then set_train_to_route_action
      when 5 then add_carriage_action
      when 6 then remove_carriage_action
      when 7 then move_trains_action
      when 8 then print_stations_action
      end
    end
  end

  private

  INVALID_INDEX_ERROR = 'Неверно выбрана станция'.freeze

  MAIN_MENU = [
    'Закончить программу',
    'Создать станции',
    'Создать поезда',
    'Создать маршруты и управлять станциями в нем (добавить, удалить)',
    'Назначить маршрут поезду',
    'Добавить вагоны к поезду',
    'Отцепить вагоны от поезда',
    'Переместить поезд по маршруту вперед или назад',
    'Просмотреть список станций или список поездов на станции'
  ].freeze
  ROUTES_MENU = [
    'Выход',
    'Создать маршрут',
    'Добавить станцию к маршруту',
    'Удалить станцию из маршрута'
  ].freeze
  MOVE_TRAIN_MENU = [
    'Выход',
    'Переместить по маршруту вперед',
    'Переместить по маршруту назад'
  ].freeze
  PRINT_STATIONS_MENU = [
    'Выход',
    'Посмотреть список станций',
    'Посмотреть список поездов на станции'
  ].freeze

  def show_menu(menu)
    puts 'Выберите действие:'
    menu.each_with_index { |item, index| puts "#{index}. #{item}" }
  end

  def select_route_action
    puts 'Введите номер маршрута'
    @railway.print_routes
    @railway.routes[gets.to_i]
  end

  def select_station_action(stations_owner)
    puts 'Введите номер станции'
    stations_owner.print_stations
    stations_owner.stations[gets.to_i]
  end

  def add_route_station_action
    route = select_route_action
    station = select_station_action(@railway)
    return puts(INVALID_INDEX_ERROR) unless station

    route.add_station(station)
  end

  def remove_route_station_action
    route = select_route_action
    station = select_station_action(route)
    return puts(INVALID_INDEX_ERROR) unless station

    route.remove_station(station)
  end

  def manage_routes_menu
    loop do
      show_menu(ROUTES_MENU)
      case gets.to_i
      when 0 then return
      when 1 then @railway.create_route
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
    train = select_train_action
    train.add_carriage(train.allowed_carriage_class.new)
  end

  def remove_carriage_action
    select_train_action.remove_carriage
  end

  def move_trains_action
    train = select_train_action
    show_menu(MOVE_TRAIN_MENU)
    case gets.to_i
    when 0 then return
    when 1 then train.move_forward
    when 2 then train.move_backward
    end
  end

  def print_trains_on_station
    puts 'Введите номер станции'
    @railway.print_stations
    @railway.stations[gets.to_i].print_trains
  end

  def print_stations_action
    show_menu(PRINT_STATIONS_MENU)
    case gets.to_i
    when 0 then return
    when 1 then @railway.print_stations
    when 2 then print_trains_on_station
    end
  end
end

Main.new.run
