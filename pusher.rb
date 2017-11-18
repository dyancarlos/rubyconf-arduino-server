require 'pusher-client'

class Pusher
  def self.socket
    socket = PusherClient::Socket.new('66c13dbdccd127e0e125', { encrypted: true })
    socket.subscribe('light')
    socket
  end
end
