FROM scratch
ADD ArchLinuxARM-aarch64-latest.tar.gz /

# Pacman setting for container
RUN sed -i 's/^CheckSpace/#CheckSpace/' /etc/pacman.conf
RUN sed -i '/^\[options\]/a DisableSandbox' /etc/pacman.conf

# Distrobox dependencies and system upgrade
RUN pacman-key --init \
 && pacman-key --populate archlinuxarm \
 && pacman -Syu --noconfirm --needed \
      bash bc coreutils curl diffutils findutils gawk glibc gnupg grep \
      less lsof man-db man-pages ncurses pinentry procps-ng shadow \
      sudo time util-linux vte-common wget which

# Distrobox creates a user matching your host UID. The stock "alarm" user is
# UID 1000 and would collide with it, so remove it.
RUN userdel -r alarm || true

# Generate a UTF-8 locale
RUN sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen \
 && locale-gen \
 && echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# Shrink the image
RUN pacman -Rns --noconfirm linux-firmware \
 linux-firmware-amd \
 linux-firmware-amdgpu \
 linux-firmware-atheros \
 linux-firmware-broadcom \
 linux-firmware-cirrus \
 linux-firmware-intel \
 linux-firmware-mediatek \
 linux-firmware-nvidia \
 linux-firmware-other \
 linux-firmware-radeon \
 linux-firmware-realtek \
 linux-firmware-ti \
 linux-firmware-whence \
 linux-aarch64
RUN pacman -Scc --noconfirm
