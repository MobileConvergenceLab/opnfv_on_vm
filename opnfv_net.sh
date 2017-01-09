#! /usr/bin/env bash

# Written by Sim Young-Bo, mobileconvergence lab. Kyung Hee Univ.

source opnfv.config

# Create Bridge
function configure_br() {
    ovs-vsctl add-br $OPNFV_BR_PRIV
    ovs-vsctl add-br $OPNFV_BR_PUB
}

function configure_rt() {
    if [ "$JUMP_MASTER" -eq "1" ]; then
        ifconfig $OPNFV_BR_PUB $JUMP_GW netmask $JUMP_MASK
    else
        route add -net $JUMP_NET netmask $JUMP_MASK dev $OPNFV_BR_PUB
    fi
}

# Create virtual port for virtual machine
# And Connect to bridge
function configure_node_port() {
    for INDEX in $(seq 0 1 $NUM_NODES)
    do
        local PORT_PRIV=$OPNFV_PREFIX_PRIV$INDEX
        ip tuntap add mode tap $PORT_PRIV
        ifconfig $PORT_PRIV up
        ovs-vsctl add-port $OPNFV_BR_PRIV $PORT_PRIV

        local PORT_PUB=$OPNFV_PREFIX_PUB$INDEX
        ip tuntap add mode tap $PORT_PUB
        ifconfig $PORT_PUB up
        ovs-vsctl add-port $OPNFV_BR_PUB $PORT_PUB
    done
}

function configure_phy_if() {
    ifconfig $PHY_IF_PRIV up
    ovs-vsctl add-port $OPNFV_BR_PRIV $PHY_IF_PRIV

    ifconfig $PHY_IF_PUB up
    ovs-vsctl add-port $OPNFV_BR_PUB $PHY_IF_PUB
}

configure_br
configure_rt
configure_node_port

if [ "$PHY_ENABLE" -eq "1" ]; then
    configure_phy_if
else
    :
fi

