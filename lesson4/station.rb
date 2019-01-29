# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
    puts "Поезд #{train.number} прибыл на станцию #{name}"
  end

  def send_train(train)
    @trains.delete(train)
    puts "Поезд #{train.number} отправлен со станции #{name}"
  end

  def trains_by_type(type)
    @trains.select { |train| train.instance_of?(type) }
  end

  # - Просматривать список поездов на станции
  def print_trains
    puts "Поезда на станции #{name}"
    @trains.each_with_index { |train, _index| puts "#(index}. #{train}" }
  end

  alias to_s name
end
