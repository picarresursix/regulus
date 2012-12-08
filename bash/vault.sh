
reg_VAULT_MOUNT_POINT="/media/aa341e43-5375-473d-8ef7-21ba586c74a4"

reg_VAULT_FILE_SYSTEM="ext4"

function reg_is_vault_open
{
    if [[ -e ~/vault/.regulus ]]; then
        echo "yes"
    else
        echo "no"
    fi
}

function reg_open_vault
{
    if [[ $(reg_is_vault_open) == "yes" ]]; then
        reg_msg_fail "vault already open."
    else
        sudo cryptsetup luksOpen $reg_VAULT_PARTITION vault
        sudo mount -t $reg_VAULT_FILE_SYSTEM /dev/mapper/vault $reg_VAULT_MOUNT_POINT
        if [[ $(reg_is_vault_open) == "yes" ]]; then
            reg_msg_success "vault opened successfully."
        else
            reg_msg_fail "vault opening failed. Vault is NOT open."
        fi
    fi
}

function reg_open_vault
{
    if [[ $(reg_is_vault_open) == "no" ]]; then
        reg_msg_fail "vault already closed."
    else
        sudo umount $reg_VAULT_MOUNT_POINT
        sudo cryptsetup luksClose vault
        if [[ $(reg_is_vault_open) == "no" ]]; then
            reg_msg_success "vault closed successfully."
        else
            reg_msg_fail "vault closing failed. Vault is STILL open."
        fi
    fi
}
