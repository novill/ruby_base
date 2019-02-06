# frozen_string_literal: true

# Для грузовых вагонов:
#
#     Добавить атрибут общего объема (задается при создании вагона)
#     Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
#     Добавить метод, который возвращает занятый объем
#     Добавить метод, который возвращает оставшийся (доступный) объем

require_relative 'carriage.rb'

class CargoCarriage < Carriage
  def to_s
    "Грузовой. Занято объема: #{occupied_space}. Свободно: #{free_space}"
  end

  private

  def validate!
    raise 'Объем должен быть больше 0' unless @full_space.positive?
  end
end
