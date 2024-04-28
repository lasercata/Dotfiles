# Grub

[`grub`](https://www.gnu.org/software/grub/) is a multiboot boot loader.

After modifying `/etc/default/grub`, run
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Configuration location
- `grub` : in `/etc/default/` ;
- `arch_grub_bg.png` : in `/boot/grub/themes/arch_background/`.

## Files
- The file `grub` contains the general configuration ;
- The file `arch_grub_bg.png` is the wallpaper.
