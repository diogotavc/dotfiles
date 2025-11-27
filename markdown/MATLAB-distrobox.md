# How to get MATLAB R2025a working on an unsupported distribution, using distrobox

1. Firstly, grab the necessary files:

```shell
wget https://www.mathworks.com/mpm/glnxa64/mpm
chmod +x
```

2. Then create and enter inside a new container, you can use any name you wish. We'll use Ubuntu 22.04 as it seems slightly more stable.

```shell
distrobox create --image ubuntu:22.04 --name mpeci-box
distrobox enter mpeci-box
```

3. Inside the container, install the dependencies manually and install MATLAB to a folder in your home (not required, but should help with permission issues):

```shell
sudo apt-get install libnss3 libatk-bridge2.0-0 libasound2 libxt6 libxft2 libsndfile1
./mpm install --release=R2025a --destination=/home/diogo/.local/MATLAB/R2025a/ MATLAB
distrobox-export --bin ~/.local/MATLAB/bin/matlab
# this doesn't need to be done, as it's stowed automatically
# cp ~/.local/MATLAB/R2025a/bin/glnxa64/cef_resources/matlab_icon.png desktop/.local/share/icons
exit
```

4. You can now remove the container desktop file, because it really isn't needed:

```shell
distrobox generate-entry -d mpeci-box
```

---

Since both the icon and desktop file are already included in this repository, no need to do any of the other manual steps. It may ask you for your account once (first launch) or twice (first and second launch).