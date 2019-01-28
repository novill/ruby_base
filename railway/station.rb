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
    @trains.select { |train| train.type == type }
  end
end
