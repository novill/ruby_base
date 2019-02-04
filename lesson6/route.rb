# frozen_string_literal: true

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!

    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    return REMOVE_STATION_ERROR if [stations[0], stations[-1]].include?(station)

    @stations.delete(station)
  end

  def to_s
    stations.join(' - ')
  end

  protected

  REMOVE_STATION_ERROR = 'Можно удалять только промежуточные станции'
  INVALID_STATIONS_MESSAGE = 'Недопустимые станции в маршруте'

  def validate!
    raise INVALID_STATIONS_MESSAGE unless stations.reject { |station| station.instance_of?(Station) }.blank?
  end
end
