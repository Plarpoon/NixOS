# NixOS flake and home-manager config

Welcome to my personal repository for NixOS and home-manager configuration. I hope you find it useful and inspiring for your own setup.

## **Notes**

- Before you dive into the code, please note that this configuration always assumes that your hosts directories contain a configuration.nix file and a hardware-configuration.nix file.

- To run the build command in a more efficient and secure way, you can use the parameter “–use-remote-sudo”, as shown in this example: **_nix flake update && nixos-rebuild switch --use-remote-sudo --flake .#bjorn_**. This way, you will only be asked to enter your sudo password when it is really necessary, and everything will go through the nix daemon.
- In the event of a system soft-lock without a functioning DNS configuration, follow these steps: Obtain the ISO and transfer it to a USB stick. Mount the system onto **_/mnt_**, execute **_nixos-enter_**, followed by **_nixos-rebuild_**.
- Useful link to track nixpkgs PR: https://nixpk.gs/pr-tracker.html

**Author:** Alessandro Suha

**Credit:** I would like to express my sincere gratitude to [Gerg-L](https://github.com/Gerg-L/nix-templates/tree/master) for sharing his minimalist flake example repo and his valuable time. He taught me a lot about how to use flakes and home-manager effectively. I also want to thank the amazing community on Discord [Nix/NixOS (unofficial)](https://discord.gg/qPJBy7qdUX) that keeps on teaching me new things about NixOS every day. You guys rock!
