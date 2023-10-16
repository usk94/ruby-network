class AccessListEntry
  attr_accessor :action, :source, :destination, :protocol

  def initialize(action, source, destination, protocol = "ip")
    @action = action
    @source = source
    @destination = destination
    @protocol = protocol
  end

  def allows_traffic?(source_ip, dest_ip)
    return source_ip.start_with?(source.split('/')[0]) &&
           dest_ip.start_with?(destination.split('/')[0])
  end
end
