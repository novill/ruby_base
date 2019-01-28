class Route
  REMOVE_STATION_ERROR = 'Можно удалять только промежуточные станции'

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    return REMOVE_STATION_ERROR if [stations[0], stations[-1]].include?(station)

    stations.delete(station)
  end
end
