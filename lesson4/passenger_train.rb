# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
# При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда,
# в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
class PassengerTrain < Train
  def add_carriage(passenger_carriage)
    return unless passenger_carriage.instance_of?(PassengerCarriage)

    @carriages << cargo_carriage
  end

  def to_s
    "Пассажирский #{number}"
  end
end
