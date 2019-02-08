# frozen_string_literal: true

# Для пассажирских вагонов:
#
#     Добавить атрибут общего кол-ва мест (задается при создании вагона)
#     Добавить метод, который "занимает места" в вагоне (по одному за раз)
#     Добавить метод, который возвращает кол-во занятых мест в вагоне
#     Добавить метод, возвращающий кол-во свободных мест в вагоне.

require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  def to_s
    "Пассажирский. Занято мест: #{occupied_space}. Свободно: #{free_space}"
  end

  validate :full_space, :type, Fixnum # вообще должен быть Integer но почему-то переменная получает Fixnum

  def occupy_space
    super(1)
  end

  private

  # def not_enough_space_error
  #   "Число мест должно быть целым и больше 0. #{@full_space} #{@full_space.class}"
  # end

  # def validate!
  #   raise not_enough_space_error  unless @full_space.positive? && @full_space.instance_of?(Fixnum)
  # end
end
