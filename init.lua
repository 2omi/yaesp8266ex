function startup()
    if file.open("init.lua") == nil then
      print("init.lua deleted")
    else
      print("Running")
      file.close("init.lua")
--      dofile("test-wifi-th-init.lua")
--      dofile("wifi_dht_tcp.lua")
--	dofile("test_adc.lua")
	dofile("wifi_dht_volt_tcp.lua")
	--node.dsleep(60*1000*1000)
    end
end

--init.lua
print("You have 5 seconds to abort Startup")
print("Waiting...")
tmr.alarm(0,5000,0,startup)
