sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo add-apt-repository ppa:videolan/stable-daily
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo add-apt-repository ppa:zedtux/naturalscrolling

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

wget https://raw.github.com/rupa/z/master/z.sh
mv z.sh ./files/

sudo apt-get update

sudo apt-get install -y build-essential
sudo apt-get install -y boot-repair
sudo apt-get install -y flashplugin-installer gsfonts-x11
sudo apt-get install -y vlc
sudo apt-get install -y skype
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y sublime-text
sudo apt-get install -y ipython
sudo apt-get install -y pyhton-pip
sudo apt-get install -y tilda
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y python-dev
sudo apt-get install -y naturalscrolling
sudo apt-get install -y default-jdk
sudo apt-get install -y gnome-tweak-tool

sudo apt-get autoremove

sudo cp -r ./files/* ~/

sudo gnome-tweak-tool
