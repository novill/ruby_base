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

  def passenger_places_dialog
    puts 'Введите количество мест в вагоне:'
    gets.to_i
  end

  def space_occupy_dialog
    puts 'Введите объем, который хотите занять в вагоне:'
    gets.to_f
  end

  def cargo_volume_dialog
    puts 'Введите объем вагона:'
    gets.to_i
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

  def print_train_carriages(train)
    carriage_count = 1
    train.each_carriage do |carriage|
      puts "#{carriage_count}. #{carriage}"
      carriage_count += 1
    end
    nil
  end

  def print_station_trains(station)
    puts "Список поездов на станции #{station}:"
    station.each_train do |train|
      puts "#{train} Вагонов: #{train.carriages_quantity}"
      print_train_carriages(train)
    end
    nil
  end

  def print_all_station_trains(stations)
    stations.each { |station| print_station_trains(station) }
    nil
  end

  private

  def print_array(array, start_message = nil)
    puts start_message if start_message
    array.each_with_index { |item, index| puts "#{index}. #{item}" }
    nil
  end
end
