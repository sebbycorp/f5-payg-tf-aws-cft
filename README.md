# AWS F5 BIGIP-WAF Terraform Environment

The following repo is used to quickly spin up an AWS+F5+BIG-IP Using Terraform. 

{
 "class": "Telemetry",
 "MyTelemetrySystem": {
   "class": "Telemetry_System",
   "allowSelfSignedCert": true,
   "systemPoller": {
     "interval": 60
   }
 },
 "GraphiteConsumer": {
   "class": "Telemetry_Consumer",
   "type": "Graphite",
   "host": "10.10.1.170",
   "protocol": "http",
   "port": 80
 },
 "StatsdConsumer": {
  "class": "Telemetry_Consumer",
  "type": "Statsd",
  "host":"10.10.1.170",
  "protocol": "udp",
  "port": 8125
 },
 "MyTelemetryListener": {
   "class": "Telemetry_Listener",
   "port": 6514
 }
}