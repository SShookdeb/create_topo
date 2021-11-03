
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
$simu_gol_gol_rani at 0.0 "$n(0) label \"USER1\""
$simu_gol_gol_rani at 0.0 "$n(1) label \"USER2\""
$simu_gol_gol_rani at 0.0 "$n(2) label \"USER3\""
$simu_gol_gol_rani at 0.0 "$n(3) label \"USER4\""
$simu_gol_gol_rani at 0.0 "$n(4) label \"USER5\""
$simu_gol_gol_rani at 0.0 "$n(5) label \"USER6\""

#code for the link the nodes with eath other 
$simu_gol_gol_rani duplex-link $n(0) $n(1) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(1) $n(2) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(2) $n(3) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(3) $n(4) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(4) $n(5) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(5) $n(0) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(0) $n(2) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(0) $n(3) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(0) $n(4) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(1) $n(3) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(1) $n(4) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(1) $n(5) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(2) $n(4) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(2) $n(5) 600Kb 10ms DropTail
$simu_gol_gol_rani duplex-link $n(3) $n(5) 600Kb 10ms DropTail



#creating the position 
$simu_gol_gol_rani duplex-link-op $n(0) $n(1) orient right-down
$simu_gol_gol_rani duplex-link-op $n(1) $n(2) orient down
$simu_gol_gol_rani duplex-link-op $n(2) $n(3) orient left-down
$simu_gol_gol_rani duplex-link-op $n(3) $n(4) orient left-up
$simu_gol_gol_rani duplex-link-op $n(4) $n(5) orient up
$simu_gol_gol_rani duplex-link-op $n(5) $n(0) orient right-up


#---First-edition with two triangel------>with tcl environment 


#set TCP protocal-->1
set tcp [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(4) $tcp
set sink0 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(5) $sink0



#set TCP protocal --->2
set tcp0 [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(5) $tcp0
set sink1 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(3) $sink1




#set TCP protocal--->3
set tcp1 [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(3) $tcp1
set sink2 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(4) $sink2



#set TCP protocal--->4
set tcp2 [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(2) $tcp2
set sink3 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(0) $sink3


#set TCP protocal--->5
set tcp3 [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(0) $tcp3
set sink4 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(1) $sink4


#set TCP protocal--->6
set tcp4 [new Agent/TCP]
$simu_gol_gol_rani attach-agent $n(5) $tcp4
set sink5 [new Agent/TCPSink]
$simu_gol_gol_rani attach-agent $n(2) $sink5


#----------------------------------------------------->second edition with anti-v
#set udp protocal--->7
set udp5 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(5) $udp5
set null6 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(1) $null6



#set udp protocal--->8
set udp6 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(0) $udp6
set null7 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(3) $null7



#set udp protocal--->9
set udp7 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(0) $udp7
set null8 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(4) $null8




#set udp protocal--->10
set udp8 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(1) $udp8
set null9 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(2) $null9


#------------------------------------------------------third edition with anti-v
#set udp protocal--->11
set udp9 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(3) $udp9
set null10 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(1) $null10

#set udp protocal--->12
set udp10 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(3) $udp10
set null11 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(2) $null11


#-------------------------------------------------->forth_edition with anti-v
#set udp protocal--->13
set udp11 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(4) $udp11
set null12 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(1) $null12


#set udp protocal--->14
set udp12 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(4) $udp12
set null13 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(2) $null13


#----------------------------------------------------->fifth_edition with last two nodes

#set udp protocal--->15
set udp13 [new Agent/UDP]
$simu_gol_gol_rani attach-agent $n(5) $udp13
set null14 [new Agent/Null]
$simu_gol_gol_rani attach-agent $n(0) $null14













$simu_gol_gol_rani connect $tcp $sink0
$simu_gol_gol_rani connect $tcp0 $sink1
$simu_gol_gol_rani connect $tcp1 $sink2
$simu_gol_gol_rani connect $tcp2 $sink3
$simu_gol_gol_rani connect $tcp3 $sink4
$simu_gol_gol_rani connect $tcp4 $sink5
#up to this------------------------------------>
$simu_gol_gol_rani connect $udp5 $null6
$simu_gol_gol_rani connect $udp6 $null7
$simu_gol_gol_rani connect $udp7 $null8
$simu_gol_gol_rani connect $udp8 $null9
$simu_gol_gol_rani connect $udp9 $null10
$simu_gol_gol_rani connect $udp10 $null11
$simu_gol_gol_rani connect $udp11 $null12
$simu_gol_gol_rani connect $udp12 $null13
$simu_gol_gol_rani connect $udp13 $null14




#-----------------------------------------------first

#set ftp traffic for tcp-->1 environment --->cbr
set ftp [new Application/FTP]
$ftp set packetSize_ 1000
$ftp set rate_ 1mb
$ftp attach-agent $tcp

#set ftp trafic for tcp-->2 environment ---->cbr0
set ftp0 [new Application/FTP]
$ftp0 set packetSize_ 1000
$ftp0 set rate_ 1mb
$ftp0 attach-agent $tcp0

#set Traffic for tcp---->3 environment ------>cbr1
set ftp1 [new Application/FTP]
$ftp1 set packetSize_ 1000
$ftp1 set rate_ 1mb
$ftp1 attach-agent $tcp1


#set Traffic for tcp---->4 environment ------>cbr2
set ftp2 [new Application/FTP]
$ftp2 set packetSize_ 1000
$ftp2 set rate_ 1mb
$ftp2 attach-agent $tcp2


#set Traffic for tcp---->5 environment ------>cbr3
set ftp3 [new Application/FTP]
$ftp3 set packetSize_ 1000
$ftp3 set rate_ 1mb
$ftp3 attach-agent $tcp3


#set Traffic for tcp---->6 environment ----->cbr4
set ftp4 [new Application/FTP]
$ftp4 set packetSize_ 1000
$ftp4 set rate_ 1mb
$ftp4 attach-agent $tcp4



#----------------------------------------------->second
#set Traffic for udp---->7 environment ---->cbr5
set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 1000
$cbr5 set rate_ 1mb
$cbr5 attach-agent $udp5


#set Traffic for udp---->8 environment ---->cbr6
set cbr6 [new Application/Traffic/CBR]
$cbr6 set packetSize_ 1000
$cbr6 set rate_ 1mb
$cbr6 attach-agent $udp6


#set Traffic for udp---->9 environment ----->cbr7
set cbr7 [new Application/Traffic/CBR]
$cbr7 set packetSize_ 1000
$cbr7 set rate_ 1mb
$cbr7 attach-agent $udp7


#set Traffic for udp---->10 environment ----->cbr8
set cbr8 [new Application/Traffic/CBR]
$cbr8 set packetSize_ 1000
$cbr8 set rate_ 1mb
$cbr8 attach-agent $udp8

#------------------------------------------------->third


#set Traffic for udp---->11 environment ------->cbr9
set cbr9 [new Application/Traffic/CBR]
$cbr9 set packetSize_ 1000
$cbr9 set rate_ 1mb
$cbr9 attach-agent $udp9


#set Traffic for udp---->12 environment -------->cbr10
set cbr10 [new Application/Traffic/CBR]
$cbr10 set packetSize_ 1000
$cbr10 set rate_ 1mb
$cbr10 attach-agent $udp10




#----------------------------------------------->forth_edition

#set Traffic for udp---->13 environment -------->cbr10
set cbr11 [new Application/Traffic/CBR]
$cbr11 set packetSize_ 1000
$cbr11 set rate_ 1mb
$cbr11 attach-agent $udp11

#set Traffic for udp---->1214 environment -------->cbr10
set cbr12 [new Application/Traffic/CBR]
$cbr12 set packetSize_ 1000
$cbr12 set rate_ 1mb
$cbr12 attach-agent $udp12




#------------------------------------------------->last_edition

#set Traffic for udp---->1214 environment -------->cbr10
set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_ 1000
$cbr13 set rate_ 1mb
$cbr13 attach-agent $udp13





$simu_gol_gol_rani at 0.0 "$ftp start"
$simu_gol_gol_rani at 0.1 "$ftp0 start"
$simu_gol_gol_rani at 0.2 "$ftp1 start"

$simu_gol_gol_rani at 0.0 "$ftp2 start"
$simu_gol_gol_rani at 0.1 "$ftp3 start"
$simu_gol_gol_rani at 0.3 "$ftp4 start"

$simu_gol_gol_rani at 0.0 "$cbr5 start"
$simu_gol_gol_rani at 0.1 "$cbr6 start"
$simu_gol_gol_rani at 0.0 "$cbr7 start"
$simu_gol_gol_rani at 0.1 "$cbr8 start"

$simu_gol_gol_rani at 0.0 "$cbr9 start"
$simu_gol_gol_rani at 0.1 "$cbr10 start"

$simu_gol_gol_rani at 0.0 "$cbr11 start"
$simu_gol_gol_rani at 0.1 "$cbr12 start"

$simu_gol_gol_rani at 0.2 "$cbr13 start"











$simu_gol_gol_rani at 6.1 "finish"

$simu_gol_gol_rani run

























