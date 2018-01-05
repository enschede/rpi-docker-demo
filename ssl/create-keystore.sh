#!/usr/bin/env bash

# Usage:
# Update localhost.req
# ./create-keystore.sh <password>

mkdir certs crl newcerts private csr
chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber

chmod 600 private/localhost.key.pem certs/localhost.crt.pem
rm private/localhost.key.pem certs/localhost.crt.pem

openssl req -new -sha256 -nodes -out csr/localhost.csr -newkey rsa:2048 -keyout private/localhost.key.pem -config <( cat localhost.req )
chmod 400 private/localhost.key.pem

openssl ca \
        -batch \
        -passin pass:$1 \
        -config server.cnf \
        -extensions server_cert \
        -days 375 \
        -notext \
        -md sha256 \
        -in csr/localhost.csr \
        -out certs/localhost.crt.pem

chmod 444 certs/localhost.crt.pem
rm csr/localhost.csr


rm index.txt index.txt.* serial serial.old crlnumber newcerts/*
