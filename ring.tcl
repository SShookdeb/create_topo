
#createing a new simulator
set simu_gol_gol_rani [new Simulator]



#open the trace file 
set n_tr_file [open new2.tr w]
$simu_gol_gol_rani trace-all $n_tr_file

#open the nam tracefile
set n_nam_file [open new2.nam w]
$simu_gol_gol_rani namtrace-all $n_nam_file

#difine a finish processure
proc finish {} {
     global simu_gol_gol_rani n_tr_file n_nam_file
     $simu_gol_gol_rani flush-trace
     close $n_nam_file
     exec nam new2.nam &
     exit 0
}


#for createing 6nodes with a for loop
for {set i 0} {$i<6} {incr i} {
set n($i) [$simu_gol_gol_rani node]
}

#for create the lebal 
$simu_gol_gol_rani at 0.0 "$n(0) label \"User1\""
$simu_gol_gol_rani at 0.0 "$n(1) label \"User2\""
$simu_gol_gol_rani at 0.0 "$n(2) label \"User3\""
$simu_gol_gol_rani at 0.0 "$n(3) label \"User4\""
$simu_gol_gol_rani at 0.0 "$n(4) label \"User5\""
$simu_gol_gol_rani at 0.0 "$n(5) label \"User6\""

#code for the link the nodes with eath other 
$simu_gol_gol_rani duplex-link $n(0) $n(1) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(1) $n(2) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(2) $n(3) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(3) $n(4) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(4) $n(5) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(5) $n(0) 600Kb 10ms DropTail

#creating the position 
$simu_gol_gol_rani duplex-link-op $n(0) $n(1) orient right-down
$simu_gol_gol_rani duplex-link-op $n(1) $n(2) orient down
$simu_gol_gol_rani duplex-link-op $n(2) $n(3) orient left-down
$simu_gol_gol_rani duplex-link-op $n(3) $n(4) orient left-up
$simu_gol_gol_rani duplex-link-op $n(4) $n(5) orient up
$simu_gol_gol_rani duplex-link-op $n(5) $n(0) orient right-up


#set UDP protocal-->1
set udp [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(0) $udp
set null0 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(3) $null0



#set udp protocal --->2
set udp0 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(3) $udp0
set null1 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(5) $null1




#set udp protocal--->3
set udp1 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(5) $udp1
set null2 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(0) $null2



$simu_gol_gol_rani connect $udp $null0
$simu_gol_gol_rani connect $udp0 $null1
$simu_gol_gol_rani connect $udp1 $null2




#set cbr traffic for udp-->1 environment 
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 1000
$cbr set rate_ 1mb
$cbr attach-agent $udp

#set cbr trafic for udp-->2 environment 
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1mb
$cbr0 attach-agent $udp0

#set Traffic for udp---->3 environment 
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1mb
$cbr1 attach-agent $udp1




$simu_gol_gol_rani at 0.0 "$cbr start"
#$simu_gol_gol_rani at 2.0 "$cbr stop"

$simu_gol_gol_rani at 0.1 "$cbr0 start"
#$simu_gol_gol_rani at 4.0 "$cbr0 stop"

$simu_gol_gol_rani at 0.2 "$cbr1 start"
$simu_gol_gol_rani at 6.0 "$cbr1 stop"



$simu_gol_gol_rani at 6.1 "finish"

$simu_gol_gol_rani run

























