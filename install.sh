sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo add-apt-repository ppa:videolan/stable-daily
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo add-apt-repository ppa:webupd8team/sublime-text-2

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update

sudo apt-get install -y boot-repair
sudo apt-get install -y flashplugin-installer gsfonts-x11
sudo apt-get install -y vlc
sudo apt-get install -y skype
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y sublime-text
sudo apt-get install -y ipython
sudo apt-get install -y pypy
sudo apt-get install -y tilda
sudo apt-get install -y git

sudo cp .bashrc ~/
sudo cp z.sh ~/