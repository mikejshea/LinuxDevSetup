var express = require('express')
var app = express()
var os = require('os');
var ifaces = os.networkInterfaces();


app.get('/', function (req, res) {
  //res.send('Hello World!')
  //console.log('Example app listening on port 3000!')
  Object.keys(ifaces).forEach(function (ifname) {
    var alias = 0;

    ifaces[ifname].forEach(function (iface) {
      if ('IPv4' !== iface.family || iface.internal !== false) {
        // skip over internal (i.e. 127.0.0.1) and non-ipv4 addresses
        return;
      }

      if (alias >= 1) {
        // this single interface has multiple ipv4 addresses
        //console.log('1:' + ifname + ':' + alias, iface.address);
        res.status(200).send(ifname + ':' + alias, iface.address);
      } else {
        // this interface has only one ipv4 adress
        //console.log('2:' + ifname, iface.address);
        res.status(200).send('{ifname:"' + ifname + '", addr:"' + iface.address + '", PID: "' + process.pid + '"}');
      }
      ++alias;
    });
  });
})

app.listen(3000, function () {
  //console.log('Example app listening on port 3000!')
  Object.keys(ifaces).forEach(function (ifname) {
    var alias = 0;

    ifaces[ifname].forEach(function (iface) {
      if ('IPv4' !== iface.family || iface.internal !== false) {
        // skip over internal (i.e. 127.0.0.1) and non-ipv4 addresses
        return;
      }

      if (alias >= 1) {
        // this single interface has multiple ipv4 addresses
        console.log(ifname + ':' + alias, iface.address);
      } else {
        // this interface has only one ipv4 adress
        console.log(ifname, iface.address);
      }
      ++alias;
    });
  });
})
