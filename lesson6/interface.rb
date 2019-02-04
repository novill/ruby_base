# frozen_string_literal: true

# Представление
class Interface
  def welcome_message
    puts 'Управление железной дорогой'
  end

  def notify(message)
    puts message if message
  end

  def select_menu_action(menu)
    loop do
      print_array(menu, 'Выберите действие:')
      menu_index = gets.to_i
      return menu_index if menu[menu_index]
    end
  end

  def select_object_dialog(object_name, object_array)
    print_array(object_array, "Выберите #{object_name}:")
    object_array[gets.to_i]
  end

  def new_station_dialog
    puts 'Введите название станиции:'
    station_name = gets.chomp
    station_name unless station_name.empty?
  end

  def new_train_dialog(alllowed_train_types)
    print_array(alllowed_train_types, 'Выберите тип поезда:')
    train_type_index = gets.to_i
    return unless alllowed_train_types[train_type_index]

    puts 'Введите номер поезда:'
    train_number = gets.chomp
    [train_type_index, train_number] unless train_number.empty?
  end

  def new_route_dialog(available_stations)
    start_station = select_object_dialog('начальную станцию', available_stations)
    end_station = select_object_dialog('конечную станцию', available_stations)
    [start_station, end_station]
  end

  def print_stations(stations)
    print_array(stations, 'Список станций:')
  end

  def print_trains(trains)
    print_array(trains, 'Список поездов:')
  end

  def print_routes(routes)
    print_array(routes, 'Список маршрутов:')
  end

  def print_trains_on_station(station)
    print_array(station.trains, "Список поездов на станции #{station}:")
  end

  private

  def print_array(array, start_message = nil)
    puts start_message if start_message
    array.each_with_index { |item, index| puts "#{index}. #{item}" }
    nil
  end
end
