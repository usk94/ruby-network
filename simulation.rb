require_relative 'device'
require_relative 'access_list'
require_relative 'nat'
require_relative 'dns'
require_relative 'vlan'
require 'net/ping'

# vlanの作成
vlan_admin = VLAN.new(10, "Admin", "10.10.10.0/24")
vlan_employee = VLAN.new(20, "Employee", "10.10.20.0/24")

# デバイスの作成
db_server = Device.new("db_server", vlan_admin)
employee_device = Device.new("employee_device", vlan_employee)

# AccessListEntryの作成
access_list = AccessList.new
access_list.add_entry("permit", "10.10.20.0/24", "10.10.10.0/24")

# VLAN20からVLAN10へのアクセスを確認
if access_list.traffic_allowed?(employee_device.ip_address, db_server.ip_address)
  # コンテナ内から実際にpingを送信する部分を修正
  pinger = Net::Ping::External.new(db_server.ip_address)
  if pinger.ping?
    puts "#{employee_device.ip_address} can ping #{db_server.ip_address}"
  else
    puts "#{employee_device.ip_address} cannot ping #{db_server.ip_address}"
  end
else
  puts "Access denied"
end

# NATの変換
nat_config = NAT.new("10.10.20.10", "203.0.113.10")
external_ip = nat_config.translate(employee_device.ip_address)
puts "Translated IP for internet access: #{external_ip}"

# DNSの解決
dns_server = DNSServer.new
dns_record = DNSRecord.new("db.companyA.local", "10.10.10.2")
dns_server.add_record(dns_record)
resolved_ip = dns_server.resolve("db.companyA.local")
puts "Resolved IP for db.companyA.local: #{resolved_ip}"
