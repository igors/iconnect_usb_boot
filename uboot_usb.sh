#!/bin/sh -e

FW_SETENV_MD5="1e9d26e2d1c860db99eaf5cf872f2cb1"
FW_SETENV=/tmp/fw_setenv
FW_PRINTENV=/tmp/fw_printenv
SAVE_SUFFIX=".bak_$(date +%F_%T)"

check_printenv()
{
    if $FW_PRINTENV 2>&1 | grep "Bad CRC"; then
        return 1
    else
        return 0
    fi
}

check_system()
{
    return 0
}

setenv()
{
    local name=$1
    local value=$2

    OLD_VALUE=$($FW_PRINTENV $name | cut -d= -f 2-)
    if [ "x$OLD_VALUE" != "x" ]; then
        # save the previous value
        echo "old value found"
#        $FW_SETENV ${name}${SAVE_SUFFIX} $OLD_VALUE
    fi

#    $FW_SETENV $name $value
}

if ! check_system ; then
    echo "This does not look like Iomega iConnect. Exiting..."
    exit 1
fi

if ! check_printenv ; then
    echo "fw_printenv is not operational. Exiting..."
    exit 1
fi