#!/bin/bash
# hotspots.sh -r ../ro_repo/code -x im -d 2014-08-19 -s 2
OPTIND=1
PREFIX=code_all
AFTER=2014-01-01
BEFORE=`date -v+1d +'%Y-%m-%d'`
REPODIR=.
SPREAD=1

function show_help() {
cat << ENDHELP
    -r source repository root (.)
    -x unique prefix for data files (code_all)
    -d date from (2014-01-01)
    -D date to (today)
    -s hotspot spread factor (1)
ENDHELP
}

while getopts "hr:x:d:s:" opt; do
	case "$opt" in
		h) show_help
		   exit 0
		   ;;
		r) REPODIR=${OPTARG}
			;;
		x) PREFIX=${OPTARG}_all
			;;
		d) AFTER=${OPTARG}
			;;
		D) BEFORE=${OPTARG}
			;;
		s) SPREAD=${OPTARG}
			;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift


WD=$PWD

cd $REPODIR

cloc . --by-file --csv --quiet --report-file=$WD/data/${PREFIX}_lines.csv --exclude-dir=dist,out,lib,gems,.idea
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=${AFTER} --before=${BEFORE} --full-history . > $WD/data/${PREFIX}_evo.log

cd $WD

java -jar code-maat-0.8.5-snapshot-standalone.jar -l data/${PREFIX}_evo.log -c git -a revisions > data/${PREFIX}_freqs.csv
python csv_as_enclosure_json.py --structure data/${PREFIX}_lines.csv --weights data/${PREFIX}_freqs.csv --weightcolumn 1 --minrevs 2 --normalizeweightsfactor ${SPREAD} > serve/json/${PREFIX}_hotspot.json
