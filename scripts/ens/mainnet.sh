#!/bin/bash

CMD="ethers-ens --network rinkeby --account $MNEMONIC --yes --wait"

function cprintf()
{
	span=$(((${2:-$(tput cols)} + ${#1}) / 2))
	printf "%${span}s\n" "$1"
}

function getAddr()
{
	grep Address <<< `$CMD lookup $1` | tr -s ' ' | cut -d' ' -f3
}

function setup()
{
	printf "┌──────────────────────────────────────────────────────────────────────────────┐\n"
	printf "│ %31s → %-42s │\n" $1 $2
	printf "└──────────────────────────────────────────────────────────────────────────────┘\n"

	lookup=`$CMD lookup $1`
	ctrl=`grep Controller <<< $lookup | tr -s ' ' | cut -d' ' -f3`
	rslv=`grep Resolver   <<< $lookup | tr -s ' ' | cut -d' ' -f3`
	addr=`grep Address    <<< $lookup | tr -s ' ' | cut -d' ' -f3`

	[[ -z "$ctrl"      ]] && echo "[set-subnode]"  && $CMD set-subnode  $1              # need to setup subdomain
	[[ -z "$2"         ]] && return                                                     # no addr → no need for a resolver
	[[ -z "$rslv"      ]] && echo "[set-resolver]" && $CMD set-resolver $1              # need to setup a resolver
	[[ "$2" != "$addr" ]] && echo "[set-addr]"     && $CMD set-addr     $1 --address $2 # wrong addr → need update
}

function reset()
{
	printf "┌──────────────────────────────────────────────────────────────────────────────┐\n"
	printf "│ %-76s │\n" "$(cprintf "Reset $1" 76)"
	printf "└──────────────────────────────────────────────────────────────────────────────┘\n"

	lookup=`$CMD lookup $1`
	ctrl=`grep Controller <<< $lookup | tr -s ' ' | cut -d' ' -f3`
	rslv=`grep Resolver   <<< $lookup | tr -s ' ' | cut -d' ' -f3`
	addr=`grep Address    <<< $lookup | tr -s ' ' | cut -d' ' -f3`

	[[ ! -z "$rslv" ]] && echo "[reset-resolver]" && $CMD set-resolver $1 --address 0x0000000000000000000000000000000000000000
	[[ ! -z "$ctrl" ]] && echo "[reset-subnode]"  && $CMD set-subnode  $1 --address 0x0000000000000000000000000000000000000000
}



# Check
$CMD lookup iexec.eth
$CMD lookup rlc.iexec.eth
$CMD lookup hub.v3.iexec.eth
$CMD lookup clerk.v3.iexec.eth
$CMD lookup apps.v3.iexec.eth
$CMD lookup datasets.v3.iexec.eth
$CMD lookup workerpools.v3.iexec.eth
$CMD lookup core.v5.iexec.eth
$CMD lookup apps.v5.iexec.eth
$CMD lookup datasets.v5.iexec.eth
$CMD lookup workerpools.v5.iexec.eth

# setup rlc.iexec.eth            0x607F4C5BB672230e8672085532f7e901544a7375

# Set new pointers
# setup v3.iexec.eth # subnode only
# setup hub.v3.iexec.eth         0x1383c16c927c4A853684d1a9c676986f25E22111
# setup clerk.v3.iexec.eth       0x3780d894DB2cB84135bBa025ba9ef0Ac518DC311
# setup apps.v3.iexec.eth        0x3322D449A43E01178672A5FBEA9E7aF3b8c7bB29
# setup datasets.v3.iexec.eth    0xC28F63b8379087F02E09da1BC62148874E730Ffd
# setup workerpools.v3.iexec.eth 0xc398052563469e6Ea7C442aBf124aADE7ec2CC92
#
# setup v5.iexec.eth # subnode only
# setup core.v5.iexec.eth        0x
# setup apps.v5.iexec.eth        0x
# setup datasets.v5.iexec.eth    0x
# setup workerpools.v5.iexec.eth 0x

# Reset old subdomains
# reset hub.iexec.eth
# reset clerk.iexec.eth
# reset apps.iexec.eth
# reset datasets.iexec.eth
# reset workerpools.iexec.eth