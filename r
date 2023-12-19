#!/bin/bash
set -e

# output directory
OUTPUT="pdf"
MAIN="main"

# Create the pdf directory if it doesn't exist
if [ ! -d "$OUTPUT" ]; then
  mkdir "$OUTPUT"
fi

pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$MAIN"
# Compile nomenclature
makeindex "$OUTPUT/$MAIN.nlo" -s nomencl.ist -o "$OUTPUT/$MAIN.nls"
# Compile index
makeindex "$OUTPUT/$MAIN"
# Compile bibliography
biber "$OUTPUT/$MAIN"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$MAIN"
# Compile glossary
makeglossaries "$OUTPUT/$MAIN"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$MAIN"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$MAIN"
