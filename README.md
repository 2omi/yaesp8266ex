# yaesp8266ex
Yet Another ESP8266 Exemple

ESP8266 : Temperature Humidity Battery and Wifi Automatic connect

Small application for temperature, humidity and battery measuring - results sending to IOT – cloud, for graphical data and alerts. 
Written with natif NodeMcu(Lua) language and firmware modules compiled here: …..(to complete).
ESP8266 card: huzzah.

Purpose: - have a small battery powered card (so small power consumption), easy Wi-fi initial configuration (without additional programs or serial console connection for setting SSID and password).

- DHT22 sensor (temperature and humidity).
- internal ESP voltage measuring or small resistors divider on ADC pin.
- enduser_setup() module for initializing WIFI (SSID and password) via Web browser.
- dsleep() for low power consumption.
- http data sending to IOT cloud.

How it works?

First time the user have to connect the wireless network:
- fire up the huzzah card (power button) – the huzzah card sets itself in a WI-FI Access Point with an SSID like this: Gadget8266...
- the user connect his laptop or smartphone to this WI-FI Access Point, then he open the browser on the laptop or smartphone and point it to this address: http://192.168.4.1

Electronics
![ESP8266 Huzzah, breadbord with DHT22 sensor](/img/20161109_172705.jpg "ESP8266 Huzzah, breadbord with DHT22 sensor")


