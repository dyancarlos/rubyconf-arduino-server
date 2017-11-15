require "artoo"
require 'pusher-client'

socket = PusherClient::Socket.new("66c13dbdccd127e0e125", { encrypted: true })
socket.subscribe('light')

def serial_port
  ports = %x(ls /dev/cu.*).split
  ports.delete_if { |p| p.include?("Bluetooth") }
  ports.first
end

connection :arduino, :adaptor => :firmata, :port => serial_port
device     :led,     :driver => :led,      :pin => 13

work do
  socket.bind('change-status') do |data|
    if data == "on"
      led.on
    else
      led.off
    end
  end
  
  socket.connect
end

