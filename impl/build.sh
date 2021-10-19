#!/bin/sh
set -e

file_exists_or_abort()
{
    filename=$1
    if [ ! -f $filename ]
    then
	echo "File '$filename' not found. Did you execute this script in the directory in which it's stored?"
	exit 2
    fi
}

file_exists_or_abort test12_impl.pcv

if [ -x ../../cryptoverif ]
then
    CV=../../cryptoverif
else
    CV=~/Downloads/cryptoverif2.04/cryptoverif
fi

CRYPTOKIT="-linkpkg -package cryptokit"

echo Proving the protocol...
"$CV" test12_impl.pcv > test12_impl.out
grep -E '(RESULT|All)' test12_impl.out | grep -v "RESULT time"
echo Generating implementation...
"$CV" -impl test12_impl.pcv



