# frozen_string_literal: true

# Для пассажирских вагонов:
#
#     Добавить атрибут общего кол-ва мест (задается при создании вагона)
#     Добавить метод, который "занимает места" в вагоне (по одному за раз)
#     Добавить метод, который возвращает кол-во занятых мест в вагоне
#     Добавить метод, возвращающий кол-во свободных мест в вагоне.

require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  attr_reader :free_places

  def initialize(all_places)
    @all_places = all_places
    @free_places = @all_places
    validate!
  end

  def occupy_one_place
    @free_places -= 1 if free_places.positive?
  end

  def occupied_places
    @all_places - free_places
  end

  def to_s
    "Пассажирский. Занято мест: #{occupied_places}. Свободно: #{free_places}"
  end

  private

  def validate!
    raise 'Число мест должно быть больше 0' unless @all_places.positive?
  end
end
