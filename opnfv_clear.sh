#! /usr/bin/env bash

# Written by Sim Young-Bo, mobileconvergence lab. Kyung Hee Univ.

source opnfv.config

function clear_br() {
    ovs-vsctl del-br $OPNFV_BR_PUB > /dev/null 2>&1
    ovs-vsctl del-br $OPNFV_PREFIX_PUB > /dev/null 2>&1
}

function clear_rt() {
    route del -net $JUMP_NET netmask $JUMP_MASK > /dev/null 2>&1
}

function clear_node_port() {
    for INDEX in $(seq 0 1 $NUM_NODES)
    do
        local PRIV_PORT=$OPNFV_PREFIX_PRIV$INDEX
        ip link delete $PRIV_PORT > /dev/null 2>&1

        local PUB_PORT=$OPNFV_PREFIX_PUB$INDEX
        ip link delete $PUB_PORT > /dev/null 2>&1
    done
}

function clear_phy_if() {
    ovs-vsctl del-br $OPNFV_BR_PRIV > /dev/null 2>&1
    ovs-vsctl del-br $OPNFV_BR_PUB > /dev/null 2>&1
}

function configure_clear() {
    clear_node_port
    clear_phy_if
    clear_rt
    clear_br
}

configure_clear
