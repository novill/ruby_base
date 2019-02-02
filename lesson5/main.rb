# frozen_string_literal: true

# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
# - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции

require_relative 'railway.rb'
require_relative 'interface.rb'
require_relative 'seed.rb'

# Будет контроллером
class Main
  def initialize
    @railway = Railway.new
    @interface = Interface.new
  end

  def run
    loop do
      action_result =
        case @interface.select_menu_action(MAIN_MENU)
        # Вот это бы задавать не через case а через указание методов сразу, не пйому пока как
        when 0 then exit
        when 1 then create_station
        when 2 then create_train
        when 3 then manage_routes_menu
        when 4 then set_train_to_route
        when 5 then add_carriage
        when 6 then remove_carriage
        when 7 then move_trains_menu
        when 8 then print_menu
        when 9 then seed_ckgd
        end
      @interface.notify(action_result)
    end
  end

  private

  MAIN_MENU = [
    'Закончить программу',
    'Создать станции',
    'Создать поезда',
    'Создать маршруты и управлять станциями в нем (добавить, удалить)',
    'Назначить маршрут поезду',
    'Добавить вагоны к поезду',
    'Отцепить вагоны от поезда',
    'Переместить поезд по маршруту вперед или назад',
    'Просмотреть список станций или список поездов на станции (еще поездов и маршрутов)',
    'Загрузиить СКЖД'
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
  PRINT_MENU = [
    'Выход',
    'Посмотреть список станций',
    'Посмотреть список поездов на станции',
    'Посмотреть список поездов',
    'Посмотреть список маршрутов'
  ].freeze

  TRAINS_TYPE_MENU = %w[
    Пассажирский
    Товарный
  ].freeze

  def create_station
    name_station = @interface.new_station_dialog
    return 'Название станции не задано' unless name_station

    if @railway.stations.index { |station| station.name == name_station } # у include нет возможности передать блок
      "Станция #{name_station} уже существует"
    else
      @railway.add_station(Station.new(name_station))
      "Станция #{name_station} создана"
    end
  end

  def create_train
    train_type_index, train_number = @interface.new_train_dialog(TRAINS_TYPE_MENU)

    train_class = Railway::TRAIN_TYPES[train_type_index]
    if @railway.trains.index { |train| train.class == train_class && train.number == train_number }
      "Поезд #{train_number} такого типа уже существует"
    else
      @railway.add_train(train_class.new(train_number))
      "Поезд #{train_number} создан"
    end
  end

  def manage_routes_menu
    loop do
      action_result =
        case @interface.select_menu_action(ROUTES_MENU)
        when 0 then return
        when 1 then create_route
        when 2 then add_route_station
        when 3 then remove_route_station
        end
      @interface.notify(action_result)
    end
  end

  def create_route
    return 'Недостаточно станций' if @railway.stations.size < 2

    start_station, end_station = @interface.new_route_dialog(@railway.stations)
    if start_station && end_station
      # пусть будут позволены круговые маршруты
      route = Route.new(start_station, end_station)
      @railway.add_route(route)
      "Маршрут #{route} создан"
    else
      'Неверно заданы станции, маршрут не создан.'
    end
  end

  def add_route_station
    return 'Не заданы маршруты' if @railway.routes.empty?

    return 'Не выбран маршрут' unless route = @interface.select_object_dialog('маршрут', @railway.routes)

    available_stations = @railway.stations - route.stations
    return 'Нет доступных станций' if available_stations.empty?

    return 'Не выбрана станция' unless new_route_station = @interface.select_object_dialog('новую станцию', available_stations)

    route.add_station(new_route_station)
    "В маршрут #{route} была добавлена станция"
  end

  def remove_route_station
    return 'Не заданы маршруты' if @railway.routes.empty?

    return 'Не выбран маршрут' unless route = @interface.select_object_dialog('маршрут', @railway.routes)

    available_stations = route.stations[1..-2] # первую и последнюю удалять нельзя
    return 'Нет доступных для удаления станций' if available_stations.empty?

    return 'Не выбрана станция' unless route_station = @interface.select_object_dialog('удаляемую станцию', available_stations)

    route.remove_station(route_station)
    "Станция #{route_station} удалена из маршрута #{route}"
  end

  def set_train_to_route
    return 'Не выбран поезд' unless train = @interface.select_object_dialog('поезд', @railway.trains)

    return 'Не выбран маршрут' unless route = @interface.select_object_dialog('маршрут', @railway.routes)

    # если уже был на какойто станции - молча отпраляем оттуда
    train.current_station&.send_train(train)

    train.route = route
    "Поезд #{train} назначен на маршрут #{route}"
  end

  def add_carriage
    return 'Не выбран поезд' unless train = @interface.select_object_dialog('поезд', @railway.trains)

    train.add_carriage(train.allowed_carriage_class.new)
    "К поезду #{train} добавлен вагон"
  end

  def remove_carriage
    return 'Не выбран поезд' unless train = @interface.select_object_dialog('поезд', @railway.trains)

    train.remove_carriage
    "У поезда #{train} убран вагон"
  end

  def move_trains_menu
    return 'Не выбран поезд' unless train = @interface.select_object_dialog('поезд', @railway.trains)
    return "Поезду #{train} не назначен маршрут" unless train.current_station

    loop do
      action_result =
        case @interface.select_menu_action(MOVE_TRAIN_MENU)
        when 0 then return
        when 1 then train_move_forward(train)
        when 2 then train_move_backward(train)
        end
      @interface.notify(action_result)
    end
  end

  def train_move_forward(train)
    if train.move_forward
      "Поезд отправлен со станции #{train.previous_station} \nПоезд прибыл на станцию #{train.current_station}"
    else
      'Поезд уже находится конечной станции'
    end
  end

  def train_move_backward(train)
    if train.move_backward
      "Поезд отправлен со станции #{train.next_station} \nПоезд прибыл на станцию #{train.current_station}"
    else
      'Поезд уже находится первой станции'
    end
  end

  def print_menu
    loop do
      action_result =
        case @interface.select_menu_action(PRINT_MENU)
        when 0 then return
        when 1 then @interface.print_stations(@railway.stations)
        when 2 then print_train_on_station
        when 3 then @interface.print_trains(@railway.trains)
        when 4 then @interface.print_routes(@railway.routes)
        end
      @interface.notify(action_result)
    end
  end

  def print_train_on_station
    return 'Не выбрана станция' unless station = @interface.select_object_dialog('станцию', @railway.stations)

    @interface.print_trains_on_station(station)
  end
end

Main.new.run
