#!/usr/bin/bash

FILES=`cd src && find *.crt`

for FILE in $FILES; do
    NICK=`echo $FILE | sed "s/.crt//g" | sed "s/icp_br./ICP-BR-/g"`
    echo "Adicionando $NICK"
    # Descomente a linha abaixo para apagar os certificados "anteriores"
    # certutil -d sql:$HOME/.pki/nssdb -D -n $NICK
    certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n $NICK -i src/$FILE
done
