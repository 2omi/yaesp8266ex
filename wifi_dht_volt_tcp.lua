HOST = "io.adafruit.com"

function dweet(temperature,humidity,voltage)
  conn=net.createConnection(net.TCP,0) 
  conn:on("receive", function(conn, pl) print("response: ",pl) end)
  conn:on("connection", function(conn, payload) 
          print("connected") 
          conn:send("GET /api/groups/66368/send.json?"
          .. "x-aio-key=xxxxxxxxxxxxxxxxxxxxxxxx_your_adafruit_key"
          .. "&temperature=" .. temperature
          .. "&humidity=" .. humidity 
          .. "&voltage=" .. voltage 
          .. " HTTP/1.1\r\n"
          .. "Host: " .. HOST .. "\r\n"
          .. "Connection: close\r\n"
          .. "Accept: */*\r\n\r\n") end)
  conn:on("disconnection", function(conn, payload)
          print("disconnected")
	  node.dsleep(60*1000*1000) end)
  conn:connect(80, HOST)
end

function check_wifi()
 local ip = wifi.sta.getip()

 if(ip==nil) then
   print("Connecting...")
 else
  tmr.stop(0)
  print("Connected to AP!")
  print(ip)
  tmr.alarm(1,20,tmr.ALARM_SINGLE,read_temp_hum_voltage)
 end
 
end

function read_temp_hum_voltage()
 pin = 1
 -- DHT module: read temp and humidity
 status, temp, humi, temp_dec, humi_dec = dht.readxx(pin)
 if status == dht.OK then
    -- Integer firmware using this example
    print(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d\r\n",
          math.floor(temp),
          temp_dec,
          math.floor(humi),
          humi_dec
    ))
    -- ADC module: read internal power
    if adc.force_init_mode(adc.INIT_VDD33)
      then node.restart()
      return
    end
    volt = adc.readvdd33(0)
    print ("System voltage (mV):", volt)

    -- send data to adafruit dashboard site
    dweet(math.floor(temp),math.floor(humi),volt)
 elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error." )
 elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out." )
 end
end

-- This section should be in init.lua
-- If wifi not in station mode, execute enduser_setup.start() and wait the user for SSID and PASSWD
-- if (wifi.getmode() ~=wifi.STATIONAP) then
if (wifi.getmode() ~= wifi.STATION) then
 enduser_setup.start(
  function()
    print("Connected to wifi as:" .. wifi.sta.getip())
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end
 )
-- elseif (not wifi.sta.getip()) then
elseif (wifi.sta.getip() == nil) then
 -- tmr.alarm(0,2000,1,check_wifi)
  tmr.alarm(0,100,1,check_wifi)
-- End section init.lua
else
  tmr.alarm(1,2000,tmr.ALARM_SINGLE,read_temp_hum_voltage)
end
