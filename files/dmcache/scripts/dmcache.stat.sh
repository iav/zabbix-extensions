#!/bin/bash
# Author: Mamedaliev K.O. <danteg41@gmail.com>
# Сбор метрик для dm-cache

DEVICE="$1"
PARAM="$2"
WRAP_DM="sudo /sbin/dmsetup status ${DEVICE}"

failed() {
	echo "ZBX_NOTSUPPORTED"; exit 1
}

get_stat() {
	awk -F'[ /]' -v pos=$1 '{print $pos}' <(${WRAP_DM}) || failed
}

case "$PARAM" in
'metadata_block_size' )
	get_stat 4
;;
'used_metadata_blocks' )
	get_stat 5
;;
'total_metadata_blocks' )
	get_stat 6
;;
'cache_block_size' )
	get_stat 7
;;
'used_cache_blocks' )
	get_stat 8
;;
'total_cache_blocks' )
	get_stat 9
;;
'read_hits' )
	get_stat 10
;;
'read_misses' )
	get_stat 11
;;
'write_hits' )
	get_stat 12
;;
'write_misses' )
	get_stat 13
;;
'demotions' )
	get_stat 14
;;
'promotions' )
	get_stat 15
;;
'dirty' )
	get_stat 16
;;
'needs_check' )
	if [ $(get_stat 25) == "-" ];then echo 0
		else echo 1
	fi
;;
'used_metadata_size' )
	metadata_block_size=$(get_stat 4)	# Fixed block size for each metadata block in sectors
	used_metadata_blocks=$(get_stat 5)
	echo $[ ${used_metadata_blocks} * ${metadata_block_size} * 512 ] || failed
;;
'total_metadata_size' )
	metadata_block_size=$(get_stat 4)
	total_metadata_blocks=$(get_stat 6)
	echo $[ ${total_metadata_blocks} * ${metadata_block_size} * 512 ] || failed
;;
'used_cache_size' )
	cache_block_size=$(get_stat 7)
	used_cache_blocks=$(get_stat 8)
	echo $[ ${used_cache_blocks} * ${cache_block_size} * 512 ] || failed
;;
'total_cache_size' )
	cache_block_size=$(get_stat 7)
	total_cache_blocks=$(get_stat 9)
	echo $[ ${total_cache_blocks} * ${cache_block_size} * 512 ] || failed
;;
* ) echo "ZBX_NOTSUPPORTED"; exit 1;;
esac

