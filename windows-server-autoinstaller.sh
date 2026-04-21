#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 1021h2"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=902edbb1-2f26-4bda-950f-64cc818f896f&P1=1776892151&P2=601&P3=2&P4=RhKv7sE9ZUmLOJhinOgY4nE4lbHqSkj3CGmABOcjma5SqZifn9MUnZ87D77xeivphd%2f7hEGfkVL62vii%2bVoAr1o8kTX7k%2bq9zxDgIxBJWFz3TtHk06t1g89uRfG6r2WHwDNsHfjX%2bujLrdjFGvgFBQVGYd%2b%2bmVjU%2fqCGRrP1WpNhfADfCi25DlvxeLbiO3Xj%2f73C2rl5UDxhcGmtAxLreQsC3XLCsKAnGVUdVPuwYm8seYq%2f2xSM06EikONIC8DHWJrpqOCjKJWemxyPHtiKbYzOX0lq4hcqTwTH7WR%2f%2fJByoqL5DIqNW2N4RYOgRYjjpQcou%2b8Jt4u%2bGPbKQBZmIw%3d%3d"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="https://fafda.to/d/pj97mvcpou4e?v=Hm0SNUnoQJ8cQ4jYTyk7MCCst3Ik7FBBsCTcGnhkwESdnFCH5Wl-X1XADijzyOblKJCs_3X6rYZGjXGdWFQemodn0S1lRaOHRBlI7SkPjow1xdkfAzOijlUnu1jz1v-zlslBTSb1r0-_YMiRyOXxh4fMI34LlSZitLPZ36Dmy9yppWaIGMQAtBceFuPLwrWHbhdZYtLW2jChxfHoMe1FN0lbBugLIT6IRmjc8MfBwxm3DloFQxbwHRKIx53t3PryoUuwnrMBkJE"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 1021h2
        img_file="windows1021h2.img"
        iso_link="http://152.53.194.161/win1021H2.img"
        iso_file="windows1021h2.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
