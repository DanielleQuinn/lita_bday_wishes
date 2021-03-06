#Happy birthday Danielle! I miss you tons 
# I hope you are having an amazing BDAY!

###Run the following dropdowns WITHOUT looking 
#or else you will likely know whats going to happen

#----Install packages----
install.packages("dplyr")
install.packages("audio")
install.packages("ggplot2")
library("dplyr")
library("audio")
library("ggplot2")

#----HAPPY BDAY DQ!!----
rm(list = ls())

# First rocket
t1 = 1:30            # number of points
size1 = 2            # size of rocket
r1_center = c(-4,10) # end center

rocket1 = data.frame(x1 = rep(r1_center[1], length(t1)) 
                     , x2 = size1*cos(t1)  + r1_center[1]
                     , y1 = rep(r1_center[2], length(t1))
                     , y2 = size1*sin(t1) + r1_center[2]
) 

# Second rocket
t2 = 1:44
size2 = 3
r2_center = c(3,12)
rocket2 = data.frame(x1 = rep(r2_center[1], length(t2)) 
                     , x2 = size2*cos(t2)  + r2_center[1]
                     , y1 = rep(r2_center[2], length(t2))
                     , y2 = size2*sin(t2) + r2_center[2]
) 


# Third rocket
t3 = 1:44
size3 = 4
r3_center = c(-2,17)
rocket3 = data.frame(x1 = rep(r3_center[1], length(t3)) 
                     , x2 = size3*cos(t3)  + r3_center[1]
                     , y1 = rep(r3_center[2], length(t3))
                     , y2 = size3*sin(t3) + r3_center[2]
) 

# Fourth rocket
t4 = 1:44
size4 = 4
r4_center = c(4,20)
rocket4 = data.frame(x1 = rep(r4_center[1], length(t4)) 
                     , x2 = size4*cos(t4)  + r4_center[1]
                     , y1 = rep(r4_center[2], length(t4))
                     , y2 = size4*sin(t4) + r4_center[2]
) 



# Plot fireworks
ggplot() +
  
  # set theme
  theme(panel.background = element_rect(fill = '#252525', colour = '#252525'),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none") + 
  
  # first rocket
  geom_point(aes(x = x2, y = y2), data = rocket1, shape = 4, colour = '#74add1')+
  geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2 ), curvature = 0.1, data = rocket1, colour = '#74add1') +
  geom_curve(aes(x = 0, y = -7, xend = r1_center[1], yend = r1_center[2] ), curvature = 0.1, colour = '#878787') +
  
  # second rocket
  geom_point(aes(x = x2, y = y2), data = rocket2, shape = 4, colour = '#fed976')+
  geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2), curvature = 0.1, data = rocket2, colour = '#fed976') +
  geom_curve(aes(x = 0, y = -7, xend = r2_center[1], yend = r2_center[2] ), curvature = -0.1, colour = '#878787') +
  
  # third rocket
  geom_point(aes(x = x2, y = y2), data = rocket3, shape = 4, colour = '#fa9fb5')+
  geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2 ), curvature = 0.1, data = rocket3, colour = '#fa9fb5') +
  geom_curve(aes(x = 0, y = -7, xend = r3_center[1], yend = r3_center[2] ), curvature = 0.1, colour = '#878787') +
  
  # fouth rocket
  geom_point(aes(x = x2, y = y2), data = rocket4, shape = 4, colour = '#addd8e')+
  geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2 ), curvature = 0.1, data = rocket4, colour = '#addd8e') +
  geom_curve(aes(x = 0, y = -7, xend = r4_center[1], yend = r4_center[2] ), curvature = -0.2, colour = '#878787') +
  
  # title
  ggtitle('Happy Birthday Danielle!') +
  
  # save
  ggsave('DQ-bdayR.png', units = 'cm', width = 15, height = 20)
#----..----
notes<-c(A=0,B=2,C=3,D=5,E=7,F=8,G=10)
pitch<-"D D E D G F# D D E D A G D D D5 B G F# E C5 C5 B G A G"
duration<-c(rep(c(0.75,0.25,1,1,1,2),2),
            0.75,0.25,1,1,1,1,1,0.75,0.25,1,1,1,2)
bday<-data_frame(pitch=strsplit(pitch," ")[[1]],
                 duration=duration)

bday<-
  bday%>%
  mutate(octave=substring(pitch,nchar(pitch))%>%
  {suppressWarnings(as.numeric(.))}%>%
    ifelse(is.na(.),4, .),
  note=notes[substr(pitch,1,1)],
  note=note+grepl("#",pitch)- 
    grepl("b",pitch)+octave*12+
    12*(note<3),
  freq=2^((note-60)/12)*440)

tempo<-120
sample_rate<-44100

make_sine<-function(freq, duration){
  wave<-sin(seq(0,duration/tempo*60,1/sample_rate)*
              freq*2*pi)
  fade<-seq(0,1,50/sample_rate)
  wave*c(fade,rep(1,length(wave)-2*length(fade)),rev(fade))
}

bday_wave<-
  mapply(make_sine,bday$freq,bday$duration)%>%
  do.call("c",.)

play(bday_wave)
