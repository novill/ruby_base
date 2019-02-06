# frozen_string_literal: true

# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
# При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда,
# в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
require_relative 'train.rb'
require_relative 'passenger_carriage.rb'

class PassengerTrain < Train
  def allowed_carriage_class
    PassengerCarriage
  end

  def to_s
    "#{number} пассажирский#{(maker ? ". Производитель: #{maker}" : '')}"
  end
end
