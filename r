#!/bin/bash
set -e

# Check if both parameters are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <output_directory> <pdf_name>"
  exit 1
fi
# Output directory
OUTPUT="$1"
# PDF name (without extension)
PDF_NAME="$2"

# Create the pdf directory if it doesn't exist
if [ ! -d "$OUTPUT" ]; then
  mkdir "$OUTPUT"
fi

pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$PDF_NAME"
# Compile nomenclature
makeindex "$OUTPUT/$PDF_NAME.nlo" -s nomencl.ist -o "$OUTPUT/$PDF_NAME.nls"
# Compile index
makeindex "$OUTPUT/$PDF_NAME"
# Compile bibliography
biber "$OUTPUT/$PDF_NAME"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$PDF_NAME"
# Compile glossary
makeglossaries "$OUTPUT/$PDF_NAME"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$PDF_NAME"
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT" "$PDF_NAME"
