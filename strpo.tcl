#create new simulator 
set ns [new Simulator]

#set the color
$ns color 1 blue
$ns color 2 red

#$ns rtproto DV

#open the trace file
set n_tr [open new1.tr w]
$ns trace-all $n_tr

#open the nam trace file 
set n_nam_fl [open new1.nam w]
$ns namtrace-all $n_nam_fl 


#difine a finish procedure
proc finish {} {
   global ns n_tr n_nam_fl
   $ns flush-trace
   close $n_nam_fl
   exec nam new1.nam &
   exit 0
}


#creating node with for loop 
for {set i 0} {$i<7} {incr i} {
set n($i) [$ns node]
}


#creating links
for {set i 1} {$i<7} {incr i} {
$ns duplex-link $n(0) $n($i) 512Kb 10ms DropTail
}


#set up the positions of all nodes
$ns duplex-link-op $n(0) $n(1) orient left-up
$ns duplex-link-op $n(0) $n(2) orient right-up
$ns duplex-link-op $n(0) $n(3) orient right
$ns duplex-link-op $n(0) $n(4) orient right-down
$ns duplex-link-op $n(0) $n(5) orient left-down
$ns duplex-link-op $n(0) $n(6) orient left


#tcp configaretion for (node1 to node4)
set tcp0 [new Agent/TCP]
$ns attach-agent $n(1) $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n(4) $sink0

$ns connect $tcp0 $sink0

#udp configaretion for (node2 to node5)
set udp0 [new Agent/UDP]
$ns attach-agent $n(2) $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(5) $null0

$ns connect $udp0 $null0


#udp1 configaretion for (node6 to node3)
set udp1 [new Agent/UDP]
$ns attach-agent $n(6) $udp1

set null1 [new Agent/Null]
$ns attach-agent $n(3) $null1

$ns connect $udp1 $null1



#CBR config1 for UDP0(n2 to n4)
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1mb
$cbr0 attach-agent $udp0


#CBR1 config for UDP1(n6 to n3)
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1mb
$cbr1 attach-agent $udp1



#FTP config for TCP(n1 to n4)
set ftp0 [new Application/FTP]
$ftp0 set packetSize_ 1000
$ftp0 set rate_ 1mb
$ftp0 attach-agent $tcp0


#Scheduling Events
#$ns rtmodel-at 0.5 down $n(0) $n(5)
#$ns rtmodel-at 0.9 up $n(0) $n(5)


#$ns rtmodel-at 0.7 down $n(0) $n(4)
#$ns rtmodel-at 1.2 up $n(0) $n(4)

$ns at 0.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"

$ns at 0.0 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"

$ns at 0.0 "$cbr1 start"
$ns at 2.0 "$cbr1 stop"

$ns at 2.1 "finish"

$ns run













 



