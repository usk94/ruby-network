class AccessList
  def initialize
    @entries = []
  end

  def add_entry(action, source, destination, protocol = "ip")
    @entries << AccessListEntry.new(action, source, destination, protocol)
  end

  def traffic_allowed?(source_ip, dest_ip)
    @entries.any? { |entry| entry.matches_traffic?(source_ip, dest_ip) }
  end

  class AccessListEntry
    attr_accessor :action, :source, :destination, :protocol

    def initialize(action, source, destination, protocol = "ip")
      @action = action
      @source = source
      @destination = destination
      @protocol = protocol
    end

    def matches_traffic?(source_ip, dest_ip)
      source_ip.start_with?(source.split('/')[0]) &&
        dest_ip.start_with?(destination.split('/')[0])
    end
  end
end
