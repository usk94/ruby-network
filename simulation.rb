require_relative 'device'
require_relative 'access_list'
require_relative 'nat'
require_relative 'dns'
require_relative 'allow_access'
require 'net/ping'

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
external_ip = nat_config.translate(employee_device.ip_address)
puts "Translated IP for internet access: #{external_ip}"

# DNSの解決
dns_server = DNSServer.new
dns_server.add_record(dns_db_server)
resolved_ip = dns_server.resolve("db.companyA.local")
puts "Resolved IP for db.companyA.local: #{resolved_ip}"
