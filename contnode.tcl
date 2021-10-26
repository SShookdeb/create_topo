#strucure of the topology
#udp Environment (0-----------> 1)

#Create a simulator object
set ns [new Simulator]


#Open the TRace file 
set nt [open out1.tr w]
$ns trace-all $nt


#OPen the NAM trace file
set nf [open out1.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns nf nt
        $ns flush-trace
        close $nf
        #exec nam out1.nam &
        exit 0 
}

#creat two nodes 
set n0 [$ns node]
set n1 [$ns node]

#create the label 
$ns at 0.0 "$n0 label \"Source\""
$ns at 0.0 "$n1 label \"Destination\""

#create the link between the nodes 
$ns duplex-link $n0 $n1 220Kb 10ms DropTail

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right-up



#setup a udp connection 
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set null0 [new Agent/Null]
$ns attach-agent $n1 $null0





#setup a CBR traffic for UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 729
$cbr0 attach-agent $udp0



#connect ion between two Agents
$ns connect $udp0 $null0
#connection complete 




#Schedule events for the CBR agents
$ns at 0.0 "$cbr0 start"
$ns at 66.0 "$cbr0 stop"

$ns at 66.1 "finish"

$ns run










