#create a simulator object
set ns [new Simulator]

#open the trace file 
set nt [open out3.tr w]
$ns trace-all $nt

#open the num trace file 
set nf [open out3.nam w]
$ns namtrace-all $nf

#difine a finish processure 
proc finish {} {
       global ns nf nt
       $ns flush-trace
       close $nf
       exec nam out3.nam &
       exit 0
}



#create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

#create a label 
$ns at 0.0 "$n0 label \"SOURCE\""
$ns at 0.0 "$n1 label \"Transmitter\""
$ns at 0.0 "$n2 label \"Destination\""


#create link between three node
$ns duplex-link $n0 $n1 500Kb 10ms DropTail
$ns duplex-link $n1 $n2 500Kb 10ms DropTail


#set up the position between nodes 
$ns duplex-link-op $n0 $n1 orient right 
$ns duplex-link-op $n1 $n2 orient right-up 


#Setting a Udp connection 
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0


set null0 [new Agent/Null]
$ns attach-agent $n2 $null0


#set up a cbr Traffic for udp
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 attach-agent $udp0

$ns connect $udp0 $null0

$ns at 0.0 "$cbr0 start"
$ns at 10.0 "$cbr0 stop"

$ns at 10.1 "finish"

$ns run

















