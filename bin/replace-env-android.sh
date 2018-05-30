#!/usr/bin/env bash
##

wget -O WhatsApp.apk `curl https://apkpure.com/whatsapp-messenger/com.whatsapp/download \
| xmlstarlet fo --html --recover 2> /dev/null \
| xmlstarlet sel -t -v '//a[@id="download_link"]/@href' -n 2> /dev/null`

IFS=\; read VERSION CLASSES_DEX < <(python dexMD5.py WhatsApp.apk | cut -d ' ' -f 2 | paste -s -d\;)
sed -i.bak -E "/_MD5_CLASSES/s/_MD5_CLASSES = \"(.*)\"/_MD5_CLASSES = \"$CLASSES_DEX\"/" yowsup/env/env_android.py
sed -i.bak -E "0,/_VERSION/s/_VERSION = \"(.*)\"/_VERSION = \"$VERSION\"/" yowsup/env/env_android.py

rm yowsup/env/env_android.py.bak