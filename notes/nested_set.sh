#!/bin/bash
#
# Nested Set Model
#
# THE BEER-WARE LICENSE
# =====================
#
# <lauri@rooden.ee> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and
# you think this stuff is worth it, you can buy me a beer in return.
# -- Lauri Rooden
#


draw_tree() {
	LINE="_____________________________________________________________"
	R=( )
	while read ROW; do 
		ID=${ROW%%|*} && ROW=${ROW#*|}
		PARENT=${ROW%%|*} && ROW=${ROW#*|}
		LFT=${ROW%%|*} && ROW=${ROW#*|}
		RGT=${ROW%%|*} && ROW=${ROW#*|}

		while [ ${#R[@]} -gt 0 ] && [ ${R[${#R[@]}-1]} -lt $RGT ]; do 
			R=(${R[@]:0:$((${#R[@]}-1))})
		done

		REPEAT=${LINE:0:${#R[@]}}
		printf "%3s[%3s] %3s-%-3s   %s- %s\n" "$ID" "$PARENT" "$LFT" "$RGT" "${REPEAT//_/  |}" "$ROW"

		R=( "${R[@]}" $RGT )
	done
}

print_tree() {
	$DB "SELECT id, parent, lft, rgt, name FROM $1 ORDER BY lft ASC;" | draw_tree
}

rebuild_tree() {
	RGT=$(($3+1))

	while read ID; do
		RGT=$(rebuild_tree $ID $RGT)
	done < <( $DB "SELECT id FROM $1 WHERE parent=$2 ORDER BY lft;" )

	$DB "UPDATE tree set lft=$3, rgt=$RGT WHERE id=$2;"
	echo $(($RGT+1))
}

resize_tree() {
	[ $3 -gt 0 ] && $DB "UPDATE $1 SET rgt=rgt+$3 WHERE rgt>=$2 AND lft<rgt;"
	$DB "UPDATE $1 SET lft=lft+($3) WHERE lft>$2 AND lft<rgt;"
	[ $3 -lt 0 ] && $DB "UPDATE $1 SET rgt=rgt+($3) WHERE rgt>$2 AND lft<rgt;"
}


