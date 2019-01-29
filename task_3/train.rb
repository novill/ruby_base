# Класс Train (Поезд):
#
#     Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#     Может принимать маршрут следования (объект класса Route).
#         При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#             Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
#     Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :carriages_quantity, :number, :speed

  def initialize(number, type, carriages_quantity)
    @number = number
    @type = type
    @carriages_quantity = carriages_quantity
    @speed = 0
    @current_station_index = nil
  end

  def increase_speed(boost)
    @speed += boost if boost > 0
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages_quantity += 1 if speed.zero?
  end

  def remove_carriage
    @carriages_quantity -= 1 if @carriages_quantity > 0 && speed.zero?
  end

  def route=(route)
    @route = route
    route.stations[0].get_train(self)
    @current_station_index = 0

  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    next_station.get_train(self)
    @current_station_index += 1
  end

  def move_backward
    return unless previous_station

    current_station.send_train(self)
    next_station.get_train(self)
    @current_station_index -= 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end
end
