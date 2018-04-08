Title: Minecraft, Python and Fedora
Category: tech
Tags: systemd, minecraft, python, py3minepi, spigot, fedora
Author: Maciej Lasyk
Summary: A story about scripting Minecraft with Python under Fedora 

<center>![Minecraft and Python]({filename}/images/minecraft-python-book.jpg)</center>

## What this is about ##

Lately I bought above book as I wanted to start teaching my 9 - years old kid
how to script a bit w/Python in his beloved Minecraft world.

The book is great, but for one thing. Its first part is about installing 
Minecraft, Spigot server and Python API on Windows or Mac or Raspberry-PI
(w/some Debian/Ubuntu based distro on board).

As we run Fedoras on our laptops (and on my server that is a physical machine 
placed in our basement) I had to somehow make it work in our environment.

## Scenario

So the scenario here is that Minecraft client (game) will be run on laptops
while Spigot server will be run on the Fedora 27 server inside of 
systemd-nspawn container. Thanks to running it on container we will not 
contaminate server's libraries.  

You may of course install all of this on your laptop instead having server
and game running on same host (localhost).

## Creating systemd-nspawn container for Minecraft server

This step is not needed at all. I just wanted to have Minecraft server 
installed under systemd-nspawn container. I will not elaborate here about 
creating containers as this is totally another matter.

If you'd like to also create systemd-nspawn container you may find following
files helpful:

- [mkosi.default](https://github.com/docent-net/minecraft/blob/master/server/mkosi.default)
  for building container image
- [minecraft.nspawn](https://github.com/docent-net/minecraft/blob/master/server/minecraft.nspawn)
  for creating nspawn container
- [minecraft-server.service](https://github.com/docent-net/minecraft/blob/master/server/minecraft-server.service)
  use it as unit file for your service
 
## Installing Spigot server on Fedora

This one is actually simple. First install all prerequisites:

```bash
sudo dnf install -y java-9-openjdk java-9-openjdk-devel git maven 
```

Now download server libraries (preferably as user **minecraft** to 
/home/minecraft/minecraft):

```bash
mkdir /home/minecraft/minecraft
cd /home/minecraft/minecraft
wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
```

And now build it - **provide same version as you have on your Minecraft game**:

```bash
git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev 1.12.2
```

After a while Your server is all built up. Now you need to install 
RaspberryJuice plugin for Bukkit that actually create socket API that will be
used by Python API helper:

```bash
git clone https://github.com/zhuowei/RaspberryJuice /home/minecraft/minecraft/RaspberryJuice
cd /home/minecraft/minecraft/RaspberryJuice
mvn package
```

When above is ready you need to copy freshly built jar to Spigot plugins 
directory (use latest version of the built file; mine was 1.11):

```bash
mkdir -p /home/minecraft/minecraft/plugins
cp /home/minecraft/minecraft/RaspberryJuice/jars/raspberryjuice-1.11.jar /home/minecraft/minecraft/plugins/ 
```

Now you need to confirm that you agree to all terms (haha lol) by creating 
eula.txt file:

```bash
echo "eula=true" > /home/minecraft/minecraft/eula.txt
```

Afterwards you just need to start the server. You may create **start.sh** 
script with following contents (remember - provide here same version as your 
Spigot server and Minecraft client):

```bash
#!/bin/sh

java -Xms512M -Xmx1024M -jar spigot-1.12.2.jar
```

or use system unit file [I provided on Github]((https://github.com/docent-net/minecraft/blob/master/server/minecraft-server.service))

## Installing Python API on Fedora

Now we need to install Python API library. Most internet guides tells about
running **sudo pip3 install ...**. I don't like it as this would pollute your
global Python path with some Minecraft API library. C'mon.

So imo we should rather create virtualenv for this:

```bash
mkvirtualenv --python=/usr/bin/python3 minecraft
```

And now we can safely install the API library:

```bash
workon minecraft
wget https://github.com/py3minepi/py3minepi/archive/master.zip
unzip master.zip
pip3 install ./py3minepi-master
```

And that's all. Now the following code run from your virtualenv should just
work:

```python
from mcpi.minecraft import Minecraft
# Provide proper IP of the server when not on localhost:
# mc = Minecraft.create('192.168.8.21')
mc = Minecraft.create()
mc.postToChat('Hello server!')
```