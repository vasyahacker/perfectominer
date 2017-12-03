# Common parameters
# All the parameters here are similar to the command line arguments

[common]
cuda_devices {DEVICES}
intensity    {INTENSITY}
templimit    {TEMPLIMIT}
pec          0
boff         0
eexit        0
tempunits    c
log          0
logfile      /dev/null
api          127.0.0.1:42000

# The miner start work from this server
# When the server is fail, the miner will try to reconnect 3 times
# After three unsuccessful attempts, the miner will switch to the next server
# You can add up to 8 servers

# main server
#[server]
#server zec-ru1.dwarfpool.com
#port   3336
#user   it1LWkTv7rqHuicRoZZseiVAhaHwJhMPcSx3.pm1
#pass   x

# additional server 1
[server]
server {SERVER}
port   {PORT}
user   {USER}
pass   x

#additional server 2
#[server]
#server zec-us1.nanopool.org
#port   6666
#user   t1LWkTv7rqHuicRoZZseiVAhaHwJhMPcSx3.pm1
#pass   x
