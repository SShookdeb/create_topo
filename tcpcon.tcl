#create a simulator object
set ns [new Simulator]

#open a trace file 
set nt [open out2.tr w]
$ns trace-all $nt

#open a nam-trace file
set nf [open out2.nam w]
$ns namtrace-all $nf



#Difine a finish procedure 
proc finish {} {
       global ns nf nt
       $ns flush-trace
       close $nf
       exec nam out2.nam &
       exit 0
}


#create two nodes
set n0 [$ns node]
set n1 [$ns node]


#create the labels
$ns at 0.0 "$n0 label \"SOURCE\""
$ns at 0.0 "$n1 label \"Destination\""


#create link between nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

#give node position (for nam)
$ns duplex-link-op $n0 $n1 orient right-down



#setup a TCP connection 
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0



set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0



#setup a FTP Traffic for tcp connection 
set ftp0 [new Application/FTP]
$tcp0 set packetSize_ 500
$ftp0 attach-agent $tcp0


$ns connect $tcp0 $sink0


#schedule events for the FTP agents 
$ns at 0.0 "$ftp0 start"
$ns at 10.0 "$ftp0 stop"

$ns at 10.1 "finish"


$ns run 



















