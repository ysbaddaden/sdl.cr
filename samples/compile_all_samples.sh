#!/bin/sh

for f in *.cr
do
	echo
	echo "Compiling $f..."
	crystal build --progress --release -o $(basename "$f" .cr) "$f"
done

echo
echo "Done."
