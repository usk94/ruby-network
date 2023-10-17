class AccessList
  def initialize
    @entries = []
  end

  def add_entry(action, source, destination)
    @entries << AccessListEntry.new(action, source, destination)
  end

  def access_allowed?(source_ip, dest_ip)
    if @entries.any? { |entry| entry.action == "deny" && entry.matches_traffic?(source_ip, dest_ip) }
      return false
    end

    @entries.any? { |entry| entry.action == "permit" && entry.matches_traffic?(source_ip, dest_ip) }
  end

  def report_access_result(source_ip, dest_ip)
    if access_allowed?(source_ip, dest_ip)
      p "この通信は通す！"
    else
      p "この通信は通さない！"
    end
  end

  class AccessListEntry
    require 'ipaddr'
    attr_accessor :action, :source, :destination

    def ip_in_cidr?(ip, cidr)
      ip_addr = IPAddr.new(ip)
      network = IPAddr.new(cidr)
      network.include?(ip_addr)
    end

    def initialize(action, source, destination)
      @action = action
      @source = source
      @destination = destination
    end

    def matches_traffic?(source_ip, dest_ip)
      ip_in_cidr?(source_ip, @source) && ip_in_cidr?(dest_ip, @destination)
    end
  end
end
