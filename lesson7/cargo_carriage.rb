# frozen_string_literal: true

# Для грузовых вагонов:
#
#     Добавить атрибут общего объема (задается при создании вагона)
#     Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
#     Добавить метод, который возвращает занятый объем
#     Добавить метод, который возвращает оставшийся (доступный) объем

require_relative 'carriage.rb'

class CargoCarriage < Carriage
  attr_reader :free_volume

  def initialize(volume)
    @full_volume = volume
    @free_volume = @full_volume
    validate!
  end

  def occupy_volume(volume)
    @free_volume -= volume unless (free_volume - volume).negative? || volume.negative?
  end

  def occupied_volume
    @full_volume - free_volume
  end

  def to_s
    "Грузовой. Занято объема: #{occupied_volume}. Свободно: #{free_volume}"
  end

  private

  def validate!
    raise 'Объем должен быть больше 0' unless @full_volume.positive?
  end
end
