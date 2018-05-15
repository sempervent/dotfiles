# TODO

the purpose of this todo is to restructure and modularize your dotfiles, configuring tmux to behave exactly as i3 but ignore if prefixed by ctrl+a

# polybar
* setup polybar on both monitors
* figure out why systray disappears on resume

## install options
options to install the dotfiles on various platforms are included:
* cygwin (mintyrc)
* xorg-server and x 
* i3 (all i3 related files)

these files are always included
* vimrc
* bashrc
* tmux
* powerline

## install scripts
### apt packages
sudo apt-get install aptitude urxvt rofi dmenu tmux vim-nox ranger w3m vim-voom exuberant-ctags python-pip python3-pip
### i3
### tmux plugin manager
### vundleVim.git
after git pulling and cloning

## arch install journalctl issues
* No NUMA configuration found
* pci 0000:04:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
* After ACPI: Power Button [PWRF], the following error occurs: `(NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info()`
* sdhci-pci 0000:03:00.0: Will use DMA mode even though HW doesn't fully claim to support it(error repeats again with :00.4)
* uvcvideo 1-1.2:1.0: Entity type for entity Extension 4 was not initialized! (also occurs for Processing 2 and Camera 1)
* iwlwifi 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
* iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-6000-6.ucode failed with error -2
* iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-6000-5.ucode failed with error -2
* kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
* Timed out waiting for device dev-disk-by\x2duuid-5f50f2b3- 


## small fixes
* the nm-applet shows a disconnected issue and won't let me choose any issues

