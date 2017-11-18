require 'pusher-client'

module Pusher
  def socket
    socket = PusherClient::Socket.new('66c13dbdccd127e0e125', { encrypted: true })
    socket.subscribe('light')
    socket
  end
end
