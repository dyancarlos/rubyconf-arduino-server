require 'artoo'
require './helpers'
require './pusher'

class Light < Artoo::Robot
  connection :arduino, adaptor: :firmata, port: Helpers::SerialPort.port
  device     :light,   driver:  :led,     pin: 8

  work do
    socket = Pusher.socket
    socket.bind('change-status') do |data|
      if data == 'on'
        light.on
      else
        light.off
      end
    end

    socket.connect
  end
end

Light.work!

