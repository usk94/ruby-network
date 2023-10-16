class NAT
  attr_accessor :inside, :outside

  def initialize(inside, outside)
    @inside = inside
    @outside = outside
  end

  def translate(source_ip)
    return inside.include?(source_ip) ? outside : source_ip
  end
end
