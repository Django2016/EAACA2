# Read data from the results.dat storing its  Variables
Data <- read.table("F:\\SEMESTER 7\\EAA\\EAACA2\\results.dat", header = TRUE)

# Stroing each column in own Variable
# Number of Transactions
Transactions <- Data$C0

# Number of Concurrent users, users accessing resources at the same time
ConcurrentUsers <- Data$N

#CPU Idle as percentage
CPUIdle <- Data$IDLE

# Time Variable used to store how long the process ran 
Time <- 10

# Function used as the Ui is a 2 step process
CPUBusy <- function(cpuIdle)
{
	# need to convert to busy CPU will be as % due to MPSTAT getting Idle as %
	convertToBusy <- 100 - cpuIdle
	
	# Divide by 100 to move from percentage to decimal so Ui is less than or equal to 1.0
	Ui <- convertToBusy / 100
	
	# returns and auto display the Ui
	return(Ui)
}

# Show Results of CPUBusy
CPUBusy(CPUIdle)

# Summary of Ui for min,max etc 
summary(CPUBusy(CPUIdle))

# Putting the Graph to a .png, creates a png file with this name filename can be removed 
png(filename="Ui VS N.png")

# creates the Graph
plot(ConcurrentUsers,CPUBusy(CPUIdle),type="l", xlab="N (No. Concurrent Users)", ylab="Ui (CPU Utilisation 0<= Ui <= 1)", main= "Ui vs N")

# Closes the png file.
dev.off()

 Throughput <- (Transactions/Time)

# the Throughput Data 
print(Throughput)

# summary of Throughput
summary(Throughput)

# Graph Throughput
png("N vs X0.png")
plot(ConcurrentUsers, Throughput, type="l",xlab="N (No. Concurrent Users)", ylab= "Throughput (TPS)",main = "Xo VS N")
dev.off()

#Sevice Demand Di = Ui / Xo second per transaction
ServiceDemand <- CPUBusy(CPUIdle) / Throughput
# Showing the Service Demand
print(ServiceDemand)

#Summary of Di
summary(ServiceDemand)

#Graph for the Service Demand
png("Di VS N.png")
plot(ConcurrentUsers, ServiceDemand,type="l",xlab="N (No. Concurrent Users)", ylab="Service Demand (Sec per transaction)", main="Di VS N")
dev.off()

# Residance Time R = N \ Ui (Little's Law) 
Residance <- ConcurrentUsers / Throughput

# Showing the Results 
print(Residance)

#Summary of the Residance
summary(Residance)

#Graph of the Residance
png("R VS N.png")
plot(ConcurrentUsers, Residance,type="l",xlab="N (No. Concurrent Users)", ylab= "Residence Time (Seconds)", main = "R VS N")
dev.off()