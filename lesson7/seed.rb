# frozen_string_literal: true

class Main
  def seed_ckgd
    return 'Уже загружены данные железной дороги' unless @railway.stations.empty?

    @railway.add_station(Station.new('Москва'))
    @railway.add_station(Station.new('Воронеж'))
    @railway.add_station(Station.new('Ростов-на-Дону'))
    @railway.add_station(Station.new('Краснодар'))
    @railway.add_station(Station.new('Сочи'))
    @railway.add_station(Station.new('Адлер'))

    @railway.add_train(PassengerTrain.new('512-ПА'))
    @railway.add_train(CargoTrain.new('151-ГР'))
    @railway.add_train(CargoTrain.new('162ГР'))

    route1 = Route.new(@railway.stations[0], @railway.stations[-1])
    route1.add_station(@railway.stations[1])
    route1.add_station(@railway.stations[2])
    route1.add_station(@railway.stations[3])
    route1.add_station(@railway.stations[4])
    @railway.add_route(route1)

    route2 = Route.new(@railway.stations[1], @railway.stations[3])
    route2.add_station(@railway.stations[2])
    @railway.add_route(route2)

    @interface.notify '-' * 50
    @interface.print_stations(@railway.stations)
    @interface.print_trains(@railway.trains)
    @interface.print_routes(@railway.routes)

    @railway.trains[0].route = route1
    @railway.trains[1].route = route1
    @railway.trains[2].route = route2
    @interface.notify '-' * 50

    # Добавить и нагрузить вагонов

    train = @railway.trains[0]
    rand(1..5).times { train.add_carriage(train.allowed_carriage_class.new(50)) }

    train.each_carriage do |passenger_carriage|
      rand(passenger_carriage.free_space).times { passenger_carriage.occupy_space }
    end # в одну строчку нечитабельно

    train = @railway.trains[1]
    rand(1..5).times { train.add_carriage(train.allowed_carriage_class.new(1000)) }

    train.each_carriage do |cargo_carriage|
      cargo_carriage.occupy_space(rand(cargo_carriage.free_space))
    end

    @interface.print_all_station_trains(@railway.stations)
    @interface.notify '-' * 50
  end
end
