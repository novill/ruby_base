# frozen_string_literal: true

# Класс Train (Поезд):
#
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
require_relative 'maker.rb'
require_relative 'instance_counter.rb'

class Train
  include Maker
  include InstanceCounter

  # Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса.

  @@all_trains = {}

  def self.find(number)
    @@all_trains[number]
  end

  attr_reader :number, :speed

  def initialize(number)
    @number = number
    validate!

    @carriages = []
    @speed = 0
    @current_station_index = nil
    @@all_trains[number] = self
    register_instance
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def increase_speed(boost)
    @speed += boost if boost.positive?
  end

  def stop
    @speed = 0
  end

  def carriages_quantity
    @carriages.size
  end

  def add_carriage(carriage)
    @carriages << carriage if carriage.instance_of?(allowed_carriage_class)
  end

  def remove_carriage
    @carriages.delete_at(-1) # пусть удаляется последний
  end

  def route=(route)
    current_station.send_train(self) if @route
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
    previous_station.get_train(self)
    @current_station_index -= 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def current_station
    @route.stations[@current_station_index] if @route
  end

  def next_station
    @route.stations[@current_station_index + 1] if @route
  end

  protected

  NUMBER_FORMAT = /^[a-zа-яё\d]{3}-?[a-zа-я\d]{2}$/i
  INVALID_TRAIN_NUMBER_MESSAGE = 'Неверный номер поезда. Формат номера ХХХ-ХХ, где Х - буква или цифра, дефис необязателен'

  def validate!
    raise INVALID_TRAIN_NUMBER_MESSAGE if number !~ NUMBER_FORMAT

    true
  end
end
