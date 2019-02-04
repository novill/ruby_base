# frozen_string_literal: true

# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
# При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда,
# в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
require_relative 'train.rb'
require_relative 'cargo_carriage.rb'

class CargoTrain < Train
  def allowed_carriage_class
    CargoCarriage
  end

  def to_s
    "Грузовой #{number}"
  end
end
