# frozen_string_literal: true

require_relative 'maker.rb'
require_relative 'valid.rb'
class Carriage
  include Maker
  include Valid

  attr_reader :free_space

  def initialize(full_space)
    @full_space = full_space
    @free_space = @full_space
    validate!
  end

  def occupy_space(load_space = 1)
    @free_space -= load_space if valid_load?(load_space)
  end

  def occupied_space
    @full_space - free_space
  end
end
