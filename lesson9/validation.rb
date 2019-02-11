# Написать модуль Validation, который:

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, type, params = nil)
      @validates ||= []
      @validates << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    PRESENCE_ERROR = 'Значение не может быть пусто'
    FORMAT_ERROR = 'Значение неверного формата'
    TYPE_ERROR = 'Значение неверного типа'

    #Методы проверки
    def validate_presence(value, _params)
      raise PRESENCE_ERROR if ['', nil].include?(value)
    end

    def validate_format(value, format)
      raise FORMAT_ERROR unless value =~ format
    end

    def validate_type(value, type)
      raise TYPE_ERROR if value.instance_of?(type)
    end

    #Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть ошибки валидации.
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    # Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
    def validate!
      return unless self.class.validates
      self.class.validates.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        method_name = "validate_#{validation[:type]}".to_sym
        send(method_name, value, validation[:params])
      end
      nil
    end
  end
end