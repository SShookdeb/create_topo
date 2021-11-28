#create a simulator object 
set ns [new Simulator]

$ns color 0 red
$ns color 1 blue

#create the trace file 
set nt [open new8.tr w]
$ns trace-all $nt

#create the num file 
set nf [open new8.nam w]
$ns namtrace-all $nf


#difine a finish procwssure 
proc finish {} {
   global ns nf nt
   $ns flush-trace 
   close $nf
   exec nam new8.nam &
   exit 
}

#create the nodes with a looop 
for {set i 0} {$i<6} {incr i} {
   set n($i) [$ns node]
} 

$ns color 1 yellow
$ns color 2 red

$n(1) shape "square"
$n(2) shape "square"


$n(0) color orange
$n(5) color blue
$n(3) color blue
$n(1) color purple
$n(2) color purple



#createing label
$ns at 0.0 "$n(0) label \"S-1\""
$ns at 0.0 "$n(1) label \"int-1\""
$ns at 0.0 "$n(3) label \"rcvr-1\""
$ns at 0.0 "$n(5) label \"rcvr-2\""
$ns at 0.0 "$n(4) label \"s-2\""
$ns at 0.0 "$n(2) label \"int-2\""



#CREATE the link between nodes 
$ns duplex-link $n(0) $n(1) 615Kb 10ms DropTail
$ns duplex-link $n(1) $n(2) 615Kb 10ms DropTail
$ns duplex-link $n(1) $n(4) 615Kb 10ms DropTail
$ns duplex-link $n(2) $n(3) 615Kb 10ms DropTail
$ns duplex-link $n(4) $n(5) 615Kb 10ms DropTail








#before createing we neeed fix the position with graphicl line
 
#left part of the tree:

$ns duplex-link-op $n(0) $n(1) orient down
$ns duplex-link-op $n(1) $n(4) orient left-down
$ns duplex-link-op $n(1) $n(2) orient right-down
$ns duplex-link-op $n(2) $n(3) orient right-down
$ns duplex-link-op $n(4) $n(5) orient left-down



set t0 [new Agent/TCP]
$ns attach-agent $n(0) $t0
set s0 [new Agent/TCPSink]
$ns attach-agent $n(3) $s0


set u0 [new Agent/UDP]
$ns attach-agent $n(4) $u0
set n0 [new Agent/Null]
$ns attach-agent $n(5) $n0



$ns connect $t0 $s0
$ns connect $u0 $n0

set f1 [new Application/FTP]
$f1 set packetSize_ 729
$t0 set fid_ 1
$f1 attach-agent $t0

set c1 [new Application/Traffic/CBR]
$c1 set packetSize_ 729
$u0 set fid_ 2
$c1 attach-agent $u0



$ns at 0.0 "$f1 start" 
$ns at 0.1 "$c1 start"


$ns at 22.0 "$f1 stop" 
$ns at 22.0 "$c1 stop"




$ns at 22.1 "finish"


$ns run







