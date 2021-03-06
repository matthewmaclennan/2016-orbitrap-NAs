nagenmzhr<-function(Cmin,Cmax,DBE,On,Sn,Nn,massmin,massmax,chargemin,chargemax){

###Define the input variables: The largest Carbon, Oxygen, Sulfur and Nitrogen numbers, Z number and mass range through which to loop.

Cmin <-as.numeric(Cmin)
Cmax <- as.numeric(Cmax)
DBE <- as.numeric(DBE)
On <- as.numeric(On)
Sn<-as.numeric(Sn)
Nn<-as.numeric(Nn)
massmin <- as.numeric(massmin)
massmax <- as.numeric(massmax)
chargemin <- as.numeric(chargemin)
chargemax <- as.numeric(chargemax)
###Next define matrix with 8 columns of all zeros. This eases the memory handling.

d<-matrix(c(0,0,0,0,0,0,0,0,0),ncol=9)

###Open the nested loop.

  for(m in 0:Nn){
    for(l in 0:Sn){
      for(i in 0:On){
        for(j in 2*0:DBE){
          for(k in Cmin:Cmax){
#The following rule if((k+m+i+l)<abs(j)) states that the total number of carbons+oxygens+nitrogens+sulfur in a possible
#naphthenic acid must be more than the Z number. Z number = -2 means there is
#one ring in the structure. It follows that a 2-carbon structure cannot have a
#ring, but a 3-C structure can have a ring. In the case of this rule being
#violated, the current loop is null and the next loop begins.

              if((k+m+i+l)<abs(j) | (k+m+i+l)>(2*(k+m+i+l)+j)){is.null(k)} else {
                charge<-seq(chargemin,chargemax,1)
                a<-12.0107*k+(2*k+2-j)*1.00794+charge+m+15.9994*i+14.00674*m+32.066*l
                if(a<massmax & a>massmin) d<-rbind(d,cbind(cbind(a,-j,k,2*k+2-j+charge+m,i,m,l,charge),
                a/cbind(a,-j,k,2*k+2-j+charge+m,i,m,l,charge)[,8]))
              }
          }
        }
      }
    }
  }
  colnames(d)<-c("Mass","Z-number","C","H","O","N","S","Charge","m/z")
  d<-d[-1,]
}
