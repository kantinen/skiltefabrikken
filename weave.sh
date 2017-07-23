#!/usr/bin/env bash
#
# Copyright (c) 2013 Datalogisk Kantineforening.
# Licenseret under EUPL, version 1.1 udelukkende.
# Licensteksten: https://joinup.ec.europa.eu/software/page/eupl/licence-eupl

function help {
  usage
  echo "Dette skalprogram smoker dit kantineskilt."
  echo ""
  echo "Som udgangspunkt smokes der et portrætskilt med dansk hoved og fod"
  echo "ud til ./output/skilt.pdf. Du har dog andre muligheder:"
  echo ""
  echo "  -o [PATH]   For at angive et navn andet end 'skilt'."
  echo "  -h          For at se denne tekst."
  echo ""
  echo "NB! Stien til TeX-filen med skiltets indhold skal altid angives som"
  echo "det sidste argument til skalprogrammet."
}

function usage {
  echo "Usage: $0 [OPTIONS] [PATH]"
}

function usage_try {
  usage
  echo "Try '$0 -h' for more information."
}

JOBNAME="skilt"

while getopts ":ho:" option; do
  case "$option" in
    m)  DANISH="true" ;;
    o)  JOBNAME="$OPTARG" ;;
    h)  help
        exit 0
        ;;
    :)  echo "Error: option requires an argument."
        usage_try
        exit 1
        ;;
    ?)  echo "Error: unknown option option."
        usage_try
        exit 1
        ;;
  esac
done

# Find det sidste argument:
for TEXTNAME; do true; done
if [ -z $TEXTNAME ]; then
  echo "Error: you must specify an input file."
  usage_try
  exit 1
fi

if [ ! -f $TEXTNAME ]; then
    echo "Error: \"$TEXTNAME\" doesn't seem to be a file."
    exit 1
fi

echo $TEXTNAME

# Fjern filendelsen:
TEXTNAME="${TEXTNAME%.*}"

OUTDIR="./output/"
mkdir -p $OUTDIR

pdflatex -output-directory=$OUTDIR -file-line-error \
  -jobname $JOBNAME \
  $TEXTNAME

