class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    return 'Можно удалять только промежуточные станции' if [stations[0], stations[-1]].include?(station)

    stations.delete(station)
  end
end
