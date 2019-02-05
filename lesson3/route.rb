# Класс Route (Маршрут):
#
#     Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
#         Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  REMOVE_STATION_ERROR = 'Можно удалять только промежуточные станции'.freeze

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    return REMOVE_STATION_ERROR if [stations[0], stations[-1]].include?(station)

    @stations.delete(station)
  end

  def print_stations
    stations.each { |station| puts station.name }
  end
end
