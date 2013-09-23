
### Common links

[putty 0.63 installer](http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.63-installer.exe)

[putty 0.63 zip](http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip)

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

How to [SSH](https://www.feralhosting.com/faq/view?question=12) into your slot.

[SSH](https://www.feralhosting.com/faq/view?question=12)

[text editor](https://www.feralhosting.com/faq/view?question=219)

You can do this from the [Install Software](https://www.feralhosting.com/manager/slot/install?) page for that slot.

You can do this from the Install Software link in your [Account Manager](https://www.feralhosting.com/manager/)

[**Install Software** link in your Manager](https://www.feralhosting.com/manager/)

[Account Manager](https://www.feralhosting.com/manager/)

You will need to have Mysql already installed. You can do this from the [**Install Software** link in your Manager](https://www.feralhosting.com/manager/)

~~~
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/installmysql.png)
~~~

The press and hold `CTRL` then press `x` to save. Press `y` to confirm.

The press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

where `username` if your Feral username and `server` if the name of the server that the relevant slot is hosted on.


### Common Commands

~~~
source ~/.bashrc && source ~/.profile
~~~

Add `PATHS` to the `~/.bashrc`#

Python `~/.local/bin`:

~~~
[ -z "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

Custom software installations to `~/programs`

~~~
[ -z "$(grep '~/programs/bin' ~/.bashrc)" ] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~