require_relative 'device'
require_relative 'access_list'
require_relative 'vlan'

# vlanの作成
vlan_admin = VLAN.new(10, "admin", "10.10.10.0/24")
vlan_employee = VLAN.new(20, "employee", "10.10.20.0/24")
vlan_guest = VLAN.new(30, "guest", "10.10.30.0/24")

# デバイスの作成
db_server = Device.new("10.10.10.1", vlan_admin)
employee_device = Device.new("10.10.20.1", vlan_employee)
guest_device = Device.new("10.10.30.1", vlan_guest)

# AccessListEntryの作成
access_list = AccessList.new
access_list.add_entry("permit", "10.10.20.0/24", "10.10.10.0/24")

# VLAN20からVLAN10へのアクセスは成功することを確認
access_list.report_access_result(employee_device.ip_address, db_server.ip_address)

# VLAN30からVLAN10へのアクセスは失敗することを確認
access_list.report_access_result(guest_device.ip_address, db_server.ip_address)
