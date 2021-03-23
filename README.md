# AC Power Checker

Probe your system for AC power. Shutdown accordingly.

## Overview

This bash snippet will probe the `acpi` command every 8 minutes to check whether or not AC power is connected to a laptop.
If AC power is not detected when the script is ran, it will give a grace period of 4 minutes before checking for AC power again. If no power is detected, your system will be safely shutdown.

### Why?

If using a laptop as a headless system, you will have the laptop plugged into its charger. Its battery will act much like a UPS. In the event of a power outage, you will lose AC power from the charger, but the laptop will still run off of battery power. This script will stop the laptop from draining its entire battery while it serves nothing.

### Prerequisites

You only need a few things:

* Root or `sudo` access to your machine
* ACPI - which can be installed with: `sudo apt install acpi`

### Installing

1. Download the script and place it wherever you would like
2. Open the file with an editor of your choice, like `nano`, or `vim`.

```
nano /path/to/script/ac_adapter_check.sh
```

3. Edit the `LOGPATH` variable to the full path of where you would like logs written to. If you do not want to keep any logs, you can set this to be `/dev/null`.

```
LOGPATH=/path/to/log/file
```

4. Open crontab as root.

```
$ sudo crontab -e -u root
```

5. Add the script to cron so it will start at reboot. We can use this line at the bottom of the crontab file:

```
@reboot /path/to/script/ac_adapter_check.sh
```

6. Reboot your machine

```
sudo reboot
```

The script should be ready to go.


## Logs

The logfile should contain 3 different messages, with timestamps on all.

* `AC pwr unplugged. Waiting 4 minutes before rechecking.` - The script has detected that your system is not receiving AC power. It will wait before checking again to be sure it is not just a brown-out.
* `****AC pwr still unplugged. Shutting down****` - The script has waited its grace period and has checked for AC power again. There is still no AC power after the grace period and your system will be issued the `shutdown now` command.
* `**AC pwr restored before timeout**` - The script has waited its grace period and has checked for AC power again. AC power has been restored. No action will be taken. The script will continue to monitor the AC power every 8 minutes after this.


## Authors
- Me :)
