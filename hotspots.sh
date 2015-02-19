#!/bin/bash
# hotspots.sh ../ro_repo/code im 2014-08-19

WD=$PWD
PREFIX=${2}_all
AFTER=${3}

cd $1

cloc . --by-file --csv --quiet --report-file=$WD/data/${PREFIX}_lines.csv --exclude-dir=dist,out,lib,gems,.idea
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=${AFTER} --full-history . > $WD/data/${PREFIX}_evo.log

cd $WD

java -jar code-maat-0.8.5-snapshot-standalone.jar -l data/${PREFIX}_evo.log -c git -a revisions > data/${PREFIX}_freqs.csv
python csv_as_enclosure_json.py --structure data/${PREFIX}_lines.csv --weights data/${PREFIX}_freqs.csv --weightcolumn 1 --minrevs 2 --normalizeweightsfactor 3 > serve/json/${PREFIX}_hotspot.json
