ip=`dig +short myip.opendns.com @resolver1.opendns.com`

config='{
  "apps": [
    {
      "serverURL": "http://ip:1337/parse",
      "appId": "id",
      "masterKey": "key",
      "appName": "MyApp"
    }
  ],
  "users": [
    {
      "user":"user",
      "pass":"pass"
    }
  ]
}'

config=${config/ip/$ip}
config=${config/id/$PARSE_SERVER_APPLICATION_ID}
config=${config/key/$PARSE_SERVER_MASTER_KEY}

echo $config > parse-dashboard/config.json

mongod --dbpath /db & 
parse-server & 
cd parse-dashboard && npm start -- --config config.json --port 4040 --allowInsecureHTTP=1