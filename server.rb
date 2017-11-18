require 'artoo'
require 'pusher-client'

def serial_port
  ports = %x(ls /dev/cu.*).split
  ports.delete_if { |p| p.include?('Bluetooth') }
  ports.first
end

socket = PusherClient::Socket.new('66c13dbdccd127e0e125', { encrypted: true })
socket.subscribe('light')

connection :arduino, adaptor: :firmata, port: serial_port
device     :light,   driver:  :led,     pin: 8

work do
  socket.bind('change-status') do |data|
    if data == 'on'
      light.on
    else
      light.off
    end
  end

  socket.connect
end
