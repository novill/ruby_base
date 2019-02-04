# frozen_string_literal: true

require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
class Railway
  TRAIN_TYPES = [PassengerTrain, CargoTrain].freeze

  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def add_station(station)
    @stations << station
  end

  def add_train(train)
    @trains << train
  end

  def add_route(route)
    @routes << route
  end
end
