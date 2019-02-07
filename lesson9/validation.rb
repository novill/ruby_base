# Написать модуль Validation, который:

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods

  # Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута, а также тип валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
    def validate(name, *args)
      raise ArgumentError, "Не задан тип валидации" if args.empty?

      case args[0]
      when :presence then {}
      when :format then {}
      when :type then {}
      else raise ArgumentError, "Неверный тип валидации"
      end
    end
  end

  module InstanceMethods

    #Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть ошибки валидации.
    def valid?
    end

    # Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
    def validate!
    end
  end
end