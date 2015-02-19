#!/bin/bash
# moduleHotspots.sh projects/code tags im 2014-08-19

WD=$PWD
PREFIX=${3}_${2}
AFTER=${4}
cd $1/$2

cloc . --by-file --csv --quiet --report-file=$WD/data/${PREFIX}_lines.csv --exclude-dir=dist,out,lib,gems
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after=${AFTER} --full-history . > $WD/data/${PREFIX}_evo.log

cd $WD

java -jar code-maat-0.8.5-snapshot-standalone.jar -l ${PREFIX}_evo.log -c git -a revisions > data/${PREFIX}_freqs.csv
sed -i '' -- "s/$2\///" data/${PREFIX}_freqs.csv
python csv_as_enclosure_json.py --structure data/${PREFIX}_lines.csv --weights data/${PREFIX}_freqs.csv --weightcolumn 1 > serve/json/${PREFIX}_hotspot.json
