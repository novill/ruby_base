# frozen_string_literal: true

# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:

module Acсessors
  # метод
  # attr_accessor_with_history
  # Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
  # при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
  #
  # Также в класс, в который подключается модуль должен добавляться инстанс-метод
  #
  # <имя_атрибута>_history
  #
  # который возвращает массив всех значений данной переменной.

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      # геттер
      define_method(name) { instance_variable_get(var_name) }

      # сеетер с историей
      define_method("#{name}=".to_sym) do |value|
        history_var_name = "@#{name}_history".to_sym

        history_var_value = instance_variable_get(history_var_name)
        if history_var_value.nil?
          instance_variable_set(history_var_name, [])
        else
          old_value = instance_variable_get(var_name)
          history_var_value << old_value
        end
        instance_variable_set(var_name, value)
      end

      #  инстанс-метод геттер истории
      define_method("#{name}_history") { instance_variable_get("@#{name}_history".to_sym) }
    end
  end

  # метод
  #
  # strong_attr_accessor
  #
  # который принимает имя атрибута и его класс. При этом создается геттер и сеттер для одноименной инстанс-переменной,
  # но сеттер проверяет тип присваемоего значения.
  # Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
  # Если тип совпадает, то значение присваивается.

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym

    # геттер
    define_method(attr_name) { instance_variable_get(var_name) }

    # сеттер
    define_method("#{attr_name}=".to_sym) do |value|
      raise ArgumentError, "Разрешены только #{attr_class} значения" unless value.instance_of?(attr_class)

      instance_variable_set(var_name, value)
    end
  end
end
