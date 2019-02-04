# frozen_string_literal: true

# Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы,
# которые подключаются автоматически при вызове include в классе:
#  - instances, который возвращает кол-во экземпляров данного класса
# Инастанс-методы:
#  - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
#    При этом данный метод не должен быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считатья по отдельности, не увеличивая счетчик инстансев базового класса.

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end
end
