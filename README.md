# KMonad + ydotool Setup on openSUSE

This guide explains how to install and run KMonad with ydotool on openSUSE, with automatic startup via systemd.

## Step 1 – Download KMonad Binaries

Download the **KMonad** binaries from the [official GitHub releases](https://github.com/kmonad/kmonad/releases).

Move the binary to `/usr/local/bin` and make it executable:

```bash
sudo mv kmonad /usr/local/bin/kmonad
sudo chmod +x /usr/local/bin/kmonad
````


## Step 2 – Install ydotool

Install ydotool using the openSUSE package manager:

```bash
sudo zypper install ydotool
```

---

## Step 3 – Set Up KMonad Configuration

Clone or copy your KMonad configuration repository.

Create the directory for KMonad files and move your config files there:

```bash
sudo mkdir -p /usr/local/share/kmonad
sudo cp * /usr/local/share/kmonad/    # Run this inside your config repo folder
```

---

## Step 4 – Make the script executable

```bash
sudo chmod +x /usr/local/share/kmonad/start-kmonad.sh
```

---

## Step 5 – Fix Permissions for `/dev/uinput`

Create a udev rule to allow access to `/dev/uinput`:

```bash
sudo nano /etc/udev/rules.d/70-uinput.rules
```

Add the following line:

```
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
```

Reload udev rules and add your user to the `input` group:

```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo usermod -aG input $USER
```

---

## Step 6 – Create Systemd Service

Create the systemd service file:

```bash
sudo nano /etc/systemd/system/kmonad.service
```

Add the following:

```ini
[Unit]
Description=KMonad + ydotoold
After=graphical.target

[Service]
Type=simple
ExecStart=/usr/local/share/kmonad/start-kmonad.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

---

## Step 7 – Enable and Start the Service

Reload systemd, enable the service to start on boot, and start it immediately:

```bash
sudo systemctl daemon-reload
sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service
```

Check the service status:

```bash
systemctl status kmonad.service
```

---

## Notes

* If you move the `/usr/local/share/kmonad` directory, the script will still work because it uses relative paths.
* After adding your user to the `input` group, you may need to log out and back in for the changes to take effect.

---

Feel free to customize the `keyboard.kbd` configuration file as needed.

---

# Enjoy your customized keyboard setup!

```
```
