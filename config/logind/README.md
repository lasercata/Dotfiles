# Systemd-logind

This is the thing responsible for the behaviour of the power key, among other things.

## Configuration location
The configuration file is located at `/etc/systemd/logind.conf`.

## Configuration
After editing the file, restart the service:
```
systemctl restart systemd-logind
```

