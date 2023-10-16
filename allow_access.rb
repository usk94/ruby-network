class AllowAccess
  def initialize
    @entries = []
  end

  def add_entry(entry)
    @entries << entry
  end

  def allows_traffic?(source_ip, dest_ip)
    @entries.any? { |entry| entry.allows_traffic?(source_ip, dest_ip) }
  end
end
