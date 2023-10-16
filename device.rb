class Device
  attr_accessor :ip_address, :vlan

  def initialize(ip_address, vlan)
    @ip_address = ip_address
    @vlan = vlan
  end

  def ping(target)
    if target.is_a?(Device)
      return "#{target.ip_address} is reachable from #{@ip_address}"
    else
      return "Invalid target"
    end
  end
end
