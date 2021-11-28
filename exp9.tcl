#create a simulator object 
set ns [new Simulator]

#create the trace file 
set nt [open new111.tr w]
$ns trace-all $nt

#create the num file 
set nf [open new111.nam w]
$ns namtrace-all $nf


#difine a finish procwssure 
proc finish {} {
   global ns nf nt
   $ns flush-trace 
   close $nf
   exec nam new111.nam &
   exit 
}

#create the nodes with a looop 
for {set i 0} {$i<6} {incr i} {
   set n($i) [$ns node]
} 
$ns color 1 green
$ns color 2 purple


$n(4) shape "square"
$n(1) shape "square"



$n(0) color blue
$n(2) color orange
$n(5) color orange

#createing label
$ns at 0.0 "$n(0) label \"Sender\""
$ns at 0.0 "$n(1) label \"int-1\""
$ns at 0.0 "$n(2) label \"rcvr-3\""
$ns at 0.0 "$n(3) label \"rcvr-2/int-2\""
$ns at 0.0 "$n(4) label \"int-3\""
$ns at 0.0 "$n(5) label \"rcvr-1\""



#CREATE the link between nodes 
$ns duplex-link $n(0) $n(1) 615Kb 10ms DropTail
$ns duplex-link $n(1) $n(2) 615Kb 10ms DropTail
$ns duplex-link $n(1) $n(3) 615Kb 10ms DropTail
$ns duplex-link $n(3) $n(4) 615Kb 10ms DropTail
$ns duplex-link $n(4) $n(5) 615Kb 10ms DropTail








#before createing we neeed fix the position with graphicl line
 
#left part of the tree:

$ns duplex-link-op $n(0) $n(1) orient down
$ns duplex-link-op $n(1) $n(2) orient left-down
$ns duplex-link-op $n(1) $n(3) orient right-down
$ns duplex-link-op $n(3) $n(4) orient left-down
$ns duplex-link-op $n(4) $n(5) orient down



set t0 [new Agent/TCP]
$ns attach-agent $n(0) $t0
set s0 [new Agent/TCPSink]
$ns attach-agent $n(5) $s0


set t1 [new Agent/TCP]
$ns attach-agent $n(0) $t1
set s1 [new Agent/TCPSink]
$ns attach-agent $n(2) $s1



$ns connect $t0 $s0
$ns connect $t1 $s1

set f1 [new Application/FTP]
$f1 set packetSize_ 729
$t0 set fid_ 1
$f1 attach-agent $t0

set f2 [new Application/FTP]
$f2 set packetSize_ 729
$t1 set fid_ 2
$f2 attach-agent $t1



$ns at 0.0 "$f1 start" 
$ns at 0.1 "$f2 start"


$ns at 22.0 "$f1 stop" 
$ns at 22.0 "$f2 stop"




$ns at 22.1 "finish"


$ns run







