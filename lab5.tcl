#create a simulator object
set simu_pikacu [new Simulator]


#open the trace file 
set siZuka_tr [open tr1.tr w]
$simu_pikacu trace-all $siZuka_tr


#open the nam trace file
set poLin_nam [open namtr1.nam w]
$simu_pikacu namtrace-all $poLin_nam

#difine a finish processure
proc finish {} {
    global simu_pikacu siZuka_tr poLin_nam
    $simu_pikacu flush-trace
    close $poLin_nam
    exec nam namtr1.nam &
    exit 0
}

#create the nodes 
set node0 [$simu_pikacu node]
set node1 [$simu_pikacu node]
set node2 [$simu_pikacu node]

#creating the label
$simu_pikacu at 0.0 "$node0 label \"Sourece\""
$simu_pikacu at 0.0 "$node1 label \"Transmitter\""
$simu_pikacu at 0.0 "$node2 label \"Destination\""


#create link between the nodes
$simu_pikacu duplex-link $node0 $node1 500Kb 10ms DropTail
$simu_pikacu duplex-link $node1 $node2 500Kb 10ms DropTail


#create the nodes position
$simu_pikacu duplex-link-op $node0 $node1 orient right-up
$simu_pikacu duplex-link-op $node1 $node2 orient right-down

set tcp_protocal [new Agent/TCP]
$simu_pikacu attach-agent $node0 $tcp_protocal

set sinku_pinku [new Agent/TCPSink]
$simu_pikacu attach-agent $node2 $sinku_pinku

set file_trans_prot [new Application/FTP]
$file_trans_prot set packetSize_ 500
$file_trans_prot attach-agent $tcp_protocal

$simu_pikacu connect $tcp_protocal $sinku_pinku

$simu_pikacu at 0.0 "$file_trans_prot start"
$simu_pikacu at 10.0 "$file_trans_prot stop"


$simu_pikacu at 10.1 "finish"

$simu_pikacu run



 















  
