require_relative 'device'
require_relative 'access_list'
require_relative 'vlan'

# VLANの作成
vlan_server = VLAN.new(10, "admin", "10.10.10.0/24")
vlan_engineer = VLAN.new(20, "engineer", "10.10.20.0/24")
vlan_marketing = VLAN.new(30, "marketing", "10.10.30.0/24")
vlan_guest = VLAN.new(40, "guest", "10.10.40.0/24")

# デバイスの作成
db_server = Device.new("10.10.10.1", vlan_server)
http_server = Device.new("10.10.10.2", vlan_server)
engineer_pc = Device.new("10.10.20.1", vlan_engineer)
marketing_pc = Device.new("10.10.30.1", vlan_marketing)
guest_sp = Device.new("10.10.40.1", vlan_guest)

# アクセスリストの作成
access_list = AccessList.new
access_list.add_entry("permit", "10.10.20.0/24", "10.10.10.0/24") # エンジニア部門からサーバー用セグメントへのアクセスを許可
access_list.add_entry("permit", "10.10.30.0/24", "10.10.10.1/32") # マーケティング部門からDBへのアクセスを許可
access_list.add_entry("deny", "10.10.30.0/24", "10.10.10.2/32") # マーケティング部門からHTTPサーバーへのアクセスをブロック

# エンジニア部門からDBへのアクセスは成功
access_list.report_access_result(engineer_pc.ip_address, db_server.ip_address)

# エンジニア部門からHTTPサーバーへのアクセスは成功
access_list.report_access_result(engineer_pc.ip_address, http_server.ip_address)

# マーケティング部門からHTTPサーバーへのアクセスは失敗
access_list.report_access_result(marketing_pc.ip_address, http_server.ip_address)

# マーケティング部門からDBサーバーへのアクセスは成功
access_list.report_access_result(marketing_pc.ip_address, db_server.ip_address)

# ゲストのスマホからDBへのアクセスは失敗
access_list.report_access_result(guest_sp.ip_address, db_server.ip_address)

# ゲストのスマホからエンジニア部門PCへのアクセスは失敗
access_list.report_access_result(guest_sp.ip_address, engineer_pc.ip_address)
