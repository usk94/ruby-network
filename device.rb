class Device
  attr_accessor :ip_address, :vlan

  def initialize(ip_address, vlan)
    @ip_address = ip_address
    @vlan = vlan
  end
end
