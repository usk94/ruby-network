class VLAN
  attr_reader :id, :name, :subnet

  def initialize(id, name, subnet)
    @id = id
    @name = name
    @subnet = subnet
  end
end
