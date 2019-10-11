# pwnagotchi-bt-tether

Launch the command as described in the INSTALL file.

You need to change the MAC address by yours on top. 
You can as well change the bluetooth network if you have a different one on your phone (I have 192.168.44.X and put a static ip on the RPI to make it simple). 
You can find your address range by launching an ifconfig in your phone terminal if needed.
Once this has been done successfully once in usb (and you can confirm tethering by pinging www.google.com and verifying that the route command is having a default route to your bluetooth and not to 10.0.0.1 anymore)

You can verify the expected output on a RC2 Vanilla

Generally issue are when the phone is not in tethering/visible/pairable mode.

```sudo systemctl status btpan``` 

should provide with success status.

If error is a2dp , this mean the phone is paired but act like an audio device. You need to enable tethering on the phone.

If error is input/output, this means that the pairing is failed and you need to unpair the pwnagotchi from your phones and restart the pairing script.

If you want to automate the connection after headless boot you can add the restart bluetooth script in root crontab

```sudo crontab -e```

And then add this:

```* * * * * /home/pi/tether-restart.sh```

Finally you can enable the ui on all ips by adding this to **/etc/pwnagotchi/config.xml**:

---

```# ui configuration
ui:
    # ePaper display can update every 3 secs anyway, set to 0 to only refresh for major data changes
    # IMPORTANT: The lifespan of an eINK display depends on the cumulative amount of refreshes. If you want to
    # preserve your display over time, you should set this value to 0.0 so that the display will be refreshed only
    # if any of the important data fields changed (the uptime and blinking cursor won't trigger a refresh).
    fps: 0.0
    display:
        enabled: true
        rotation: 180
        # Possible options inkyphat/inky, papirus/papi, waveshare_1/ws_1 or waveshare_2/ws_2
        type: 'waveshare_2'
        # Possible options red/yellow/black (black used for monocromatic displays)
        color: 'black'
        video:
            enabled: true
            address: '0.0.0.0'
            port: 8080
```
---


This should then make the tethering automatic and you can access ui, bettercap and ssh while being connecting to the internet.
Tested on Android but should work on iOS as well.

You can install **speedtest-cli** to test speed via bluetooth:


```sudo apt-get install speedtest-cli```

Then you can test with:

```speedtest-Cli --simple```
