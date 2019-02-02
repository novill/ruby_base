# frozen_string_literal: true

class Main
  def seed_ckgd
    @railway.add_station(Station.new('Москва'))
    @railway.add_station(Station.new('Воронеж'))
    @railway.add_station(Station.new('Ростов-на-Дону'))
    @railway.add_station(Station.new('Краснодар'))
    @railway.add_station(Station.new('Сочи'))
    @railway.add_station(Station.new('Адлер'))
    @railway.add_train(PassengerTrain.new('512C'))
    @railway.add_train(CargoTrain.new('151С'))

    route = Route.new(@railway.stations[0], @railway.stations[-1])
    route.add_station(@railway.stations[1])
    route.add_station(@railway.stations[2])
    route.add_station(@railway.stations[3])
    route.add_station(@railway.stations[4])
    @railway.add_route(route)

    route = Route.new(@railway.stations[0], @railway.stations[3])
    route.add_station(@railway.stations[1])
    @railway.add_route(route)

    @interface.print_stations(@railway.stations)
    @interface.print_trains(@railway.trains)
    @interface.print_routes(@railway.routes)
    'СКЖД Загружена'
  end
end
