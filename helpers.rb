module Helpers
  class SerialPort
    def self.port
      ports = %x(ls /dev/cu.*).split
      ports.delete_if { |p| p.include?('Bluetooth') }
      ports.first
    end
  end
end
