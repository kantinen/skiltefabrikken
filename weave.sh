#!/bin/bash
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
  echo "  -l          For et vandret skilt."
  echo "  -e          For English header and footer."
  echo "  -b          For en blank skabelon."
  echo "  -o [PATH]   For at angive et navn andet end 'skilt'."
  echo "  -h          For at se denne tekst."
}

function usage {
  echo "Usage: $0 [OPTIONS] [PATH]"
}

function usage_try {
  usage
  echo "Try '$0 -h' for more information."
}

PORTRAIT="true"
DANISH="true"
NOTBLANK="true"
JOBNAME="skilt"

while getopts ":helbo:" option; do
  case "$option" in
    l)  PORTRAIT="false" ;;
    e)  DANISH="false" ;;
    b)  NOTBLANK="false" ;;
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

BASENAME="main.tex"

if [ ! -f $BASENAME ]; then
    echo "Error: \"$BASENAME\" doesn't seem to be a file."
    exit 1
fi

if [ ! -f $TEXTNAME ]; then
    echo "Error: \"$TEXTNAME\" doesn't seem to be a file."
    exit 1
fi

echo $BASENAME
echo $TEXTNAME

# Fjern filendelserne:
BASENAME="${BASENAME%.*}"
TEXTNAME="${TEXTNAME%.*}"


OUTDIR="./output/"
mkdir -p $OUTDIR

COMMAND=$( cat <<EOF
\\newif\\ifportrait\\portrait$PORTRAIT
\\newif\\ifdanish\\danish$DANISH
\\newif\\ifnotblank\\notblank$NOTBLANK
\\newcommand\\content[0]{\\input{$TEXTNAME}}\\input{$BASENAME}
EOF
)

pdflatex -output-directory=$OUTDIR -file-line-error \
  -jobname $JOBNAME \
  $COMMAND

