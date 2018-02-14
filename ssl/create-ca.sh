#!/usr/bin/env bash

# Usage ./create-ca.sh <password>

mkdir certs crl newcerts private csr
chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber

function createCA {
    echo "(Re)create CA with private key and certificate as 'ca'"

    chmod 600 private/ca.key.pem certs/ca.cert.pem
    rm private/ca.key.pem certs/ca.cert.pem

    openssl genrsa -aes256 -passout pass:$1 -out private/ca.key.pem 4096
    chmod 400 private/ca.key.pem

    openssl req -config ca.cnf \
            -subj "/C=NL/ST=The Netherlands/L=Enschede/O=PersonalCA/CN=PersonalCA" \
            -passin pass:$1 \
            -key private/ca.key.pem \
            -new \
            -x509 \
            -days 7300 \
            -sha256 \
            -extensions v3_ca \
            -out certs/ca.cert.pem
    chmod 444 certs/ca.cert.pem
}

createCA $1

rm index.txt serial crlnumber
