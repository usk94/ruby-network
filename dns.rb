class DNSRecord
  attr_accessor :domain, :ip_address

  def initialize(domain, ip_address)
    @domain = domain
    @ip_address = ip_address
  end

  def resolve(domain_name)
    return domain == domain_name ? ip_address : nil
  end
end

class DNSServer
  def initialize
    @records = []
  end

  def add_record(record)
    @records.push(record)
  end

  def resolve(domain_name)
    @records.each do |record|
      resolved_ip = record.resolve(domain_name)
      return resolved_ip if resolved_ip
    end
    return "Domain not found"
  end
end
