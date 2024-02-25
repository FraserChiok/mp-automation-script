## Setup LVM Script

This script automates the setup of Logical Volume Management (LVM) on a Linux system. It creates a logical volume, formats it with ext4 filesystem, mounts it to a specified directory, and adds an entry to /etc/fstab for persistent mounting.

### Prerequisites

- This script is intended for use on a Linux system with Logical Volume Management (LVM) support.
- Ensure that you have sudo privileges or run the script with root access.

### Usage

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/FraserChiok/mp-automation-script.git
    ```

2. Navigate to the directory containing the script:

    ```bash
    cd mp-automation-script/
    ```

3. Make the script executable:

    ```bash
    chmod +x setup_lvm.sh
    ```

4. Customize the script by modifying the variables at the beginning:

    ```bash
    # Define variables
    ACTUALDIR="/var/log"       # Specify the directory to mount the logical volume.
    VG="vg0"                   # Specify the volume group name.
    DEVICE="/dev/nvme0n1"      # Specify the device on which to create the volume group.
    LV_SIZE="2G"               # Specify the size of the logical volume.
    ```

5. Execute the script:

    ```bash
    ./setup_lvm.sh
    ```

6. After running the script, manually check the logical volume by using `lsblk`:

    ```bash
    lsblk
    ```

### Example Output

```plaintext
NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1             259:0    0  100G  0 disk 
└─vg0-newvarlog_lv  253:0    0    2G  0 lvm  /var/log
