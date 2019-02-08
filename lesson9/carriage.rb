# frozen_string_literal: true

require_relative 'maker.rb'
require_relative 'validation.rb'
class Carriage
  include Maker
  include Validation

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

  private

  def valid_load?(load_space)
    load_space.positive? && (free_space - load_space).positive?
  end

end
