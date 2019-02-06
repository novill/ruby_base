# frozen_string_literal: true

# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'instance_counter.rb'
require_relative 'valid.rb'

class Station
  include InstanceCounter
  include Valid

  def self.all
    @@all
  end

  @@all = []

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate!

    @trains = []
    @@all << self
    register_instance
  end

  # У класса Station: написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.
  def each_train
    @trains.each { |train| yield(train) } if block_given?
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.instance_of?(type) }
  end

  alias to_s name

  protected

  INVALID_STATION_NAME_MESSAGE = 'Неверное название станции. Название должно быть длиной не менее 2 символов'

  def validate!
    raise INVALID_STATION_NAME_MESSAGE if name.length < 2
  end
end
