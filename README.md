# setup
for registration just copy `config/config.dist` to config/config file and do docker build.

After docker has been built run following commands in docker shell with XXXXXXXXXX replaced with phone number.
```
python yowsup-cli registration --requestcode sms --phone 91XXXXXXXXXX --cc 91 --mcc 222 --mnc 10 -E android
```

when you recieve your sms run following with xxx-xxx and XXXXXXXXXX replaced with whatsapp code and phone number.
```
python yowsup-cli registration --register xxx-xxx --phone 91XXXXXXXXXX --cc 91 -E android
```

you will get something similar to this in output of previous command
```
status: b'ok'
login: b'91XXXXXXXXXX'
pw: b'xxxxxxxxxxxxxxxxxxxx='
type: b'existing'
expiration: 4444444444.0
kind: b'free'
price: b'$0.99'
cost: b'0.99'
currency: b'USD'
price_expiration: 1528285229
```

replace config/config file with following values 
* phone should be replaced by `login` 
* password should be replaced by `pw` 

docker build again with valid username & password and now you are ready to rock the boat !!

if wanna try running demos here is the command!

```yowsup-cli demos --yowsup --config config```
