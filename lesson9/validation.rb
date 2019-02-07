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

      var_name = "@#{name}".to_sym

      case args[0]
      when :presence then
        define_method("_validate_presence_of_#{name}") { raise ArgumentError, "Аттрибут #{name} не может быть пуст" if ['', nil].include?(instance_variable_get(var_name)) }
      when :format then
        raise ArgumentError, "Не задан формат" if args[1].nil?
        raise ArgumentError, "Неверно задан формат" unless args[1].instance_of?(Regexp)
        define_method("_validate_format_of_#{name}") { raise ArgumentError, "Аттрибут #{name} неверного формата" if instance_variable_get(var_name) !~ args[1] }
      when :type then
        raise ArgumentError, "Не задан тип" if args[1].nil?
        raise ArgumentError, "Неверно задан тип" unless args[1].class == Class
        define_method("_validate_type_of_#{name}") { raise ArgumentError, "Аттрибут #{name} неверного типа" unless instance_variable_get(var_name).instance_of?(args[1]) }
      else raise ArgumentError, "Неверный тип валидации"
      end
    end
  end

  module InstanceMethods

    #Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть ошибки валидации.
    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    # Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
    def validate!
      public_methods.select { |method_sym| method_sym.to_s['_validate_'] }.each do |method_sym|
        send(method_sym)
      end
      nil
    end
  end
end