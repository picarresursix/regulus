
function vg_is_open
{
    if [[ $(ls $1) == "" ]]
    then
        echo "no"
    else
        echo "yes"
    fi
}

function vg_identifier
{
    if [[ $# < 1 ]];
    then
        echo "[FAIL] I need a string to identify!"
    else
        identifier=$(sed "s/[^a-zA-Z0-9]//g" <<< $1)
        index=0
        while [[ $(ls /dev/mapper | grep $identifier) != "" ]]
        do
            ((index=$index+1))
            identifier=$identifier$index
        done
        echo $identifier
    fi
}

function vg_open
{
    if (($# < 2));
    then
        echo "Too few arguments!"
        echo "Usage: vg_open /dev/<partition> </mount/point>"
    else
        identifier=$(vg_identifier $1)
        sudo cryptsetup luksOpen $1 $identifier
        sudo mount -t ext4 /dev/mapper/$identifier $2
        if [[ $(vg_is_open $2) == "yes" ]]; then
            echo $2" opened successfully."
        else
            echo $2" opening failed. "$2" is NOT open."
        fi
    fi  
}

function vg_close
{
    if (($# < 2));
    then
        echo "Too few arguments!"
        echo "Usage: vg_close /dev/<partition> </mount/point>"
    else
        identifier=$(vg_identifier $1)
        sudo umount $2
        sudo cryptsetup luksClose $identifier
        if [[ $(vg_is_open $2) == "no" ]]; then
            echo $2" closed successfully."
        else
            echo $2" closing failed. "$2" is NOT closed."
        fi
    fi
}

vg_VAULT_MOUNT_POINT="/media/aa341e43-5375-473d-8ef7-21ba586c74a4"

vg_VAULT_PARTITION=/dev/sda7

function vg_open_vault
{
    vg_open $vg_VAULT_PARTITION $vg_VAULT_MOUNT_POINT
}

function vg_close_vault
{
    vg_close $vg_VAULT_PARTITION $vg_VAULT_MOUNT_POINT
}

vg_GHOST_MOUNT_POINT=/media/4cb875da-6fbf-48eb-b450-122c345489c1

function vg_open_ghost
{
    if [[ $# < 1 ]]
    then
        echo "[FAIL] I need the name of the partition containing the ghost"
    else
        vg_open $1 $vg_GHOST_MOUNT_POINT
    fi
}

function vg_close_ghost
{
    if [[ $# < 1 ]]
    then
        echo "[FAIL] I need the name of the partition containing the ghost"
    else
        vg_close $1 $vg_GHOST_MOUNT_POINT
    fi
}

function vg_clone
{
    echo "**$****** Copying ~/ ************"
    rsync -r -P -t -F ~/ $vg_GHOST_MOUNT_POINT
    echo ""
    echo "******** Copying vault **********"
    echo ""
    rsync -r -P -t -F $vg_VAULT_MOUNT_POINT/ $vg_GHOST_MOUNT_POINT/vault
    echo ""
    echo "[DONE]"
    date > ~/last-clone
}
