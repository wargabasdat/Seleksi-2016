#Local-Setup
rm(list=ls(all=TRUE))
setwd("G:")

#Library
library(tm)
library(RTextTools)
library(ggplot2)

#Function
#Every function is used for easier editting only (mostly control loop)

#Erasing a list of string from a data frame
cleanStr <- function(x, y) {
	for (i in 1:(length(x))){
		if (i %% 2){
			y <- gsub(paste("^", x[i], " ", sep = ""),paste(x[i+1], " ", sep=""),y)
			y <- gsub(paste(" ", x[i]," ", sep = ""),paste(" ", x[i+1], " ", sep = ""), y)
			y <- gsub(paste(" ",x[i], "$", sep = ""),paste(" ", x[i+1], sep=""),y)
		}
	}
	return(y)
}

#Splitting list with pre-defined format into data frame
splitData <- function(x) {
	y <- NULL
	z <- NULL
	for (i in 1:(length(x))){
		if (i %% 2){
			y <- c(y,x[i])
		}
		else {
			z <- c(z,x[i])
		}
	}
	return(data.frame(Job = y, Category = z))
}

#Remove trainer data from original data
removeData <- function(x,y) {
	for (i in 1:(dim(x)[1])){
		del <- grep(paste("^",x[i,1],"$",sep=""),as.character(y))
		if(length(del) > 0) {
			y <- y[-c(del)]
		}
		if(length(del) > 1) {
			print(i)
			print("Double Result")
		}
		if(length(del) == 0) {
			print(i)
			print("No Result")
		}
		rm(del)
	}
	return(y)
}

#Read Data, Ordering, and Adding Category Column
sTrain <- read.csv("Salaries.csv")
sTrain <- sTrain[order(sTrain$JobTitle),]
temp <- sTrain[,3]
sTrain$Category <- temp
rm(temp)
sTrain$Category <- as.factor(tolower(sTrain$Category))

#Cleaning (or it should be)
#Replacing common sign and number
sTrain$Category <- gsub(" [0-9]*$","",sTrain$Category)
sTrain$Category <- gsub(" [i]*$","",sTrain$Category)
sTrain$Category <- gsub(" [i]* "," ",sTrain$Category)
sTrain$Category <- gsub(" [i]*/[i]*$","",sTrain$Category)
sTrain$Category <- gsub(" iv$","",sTrain$Category)
sTrain$Category <- gsub(" v[i]*$","",sTrain$Category)
sTrain$Category <- gsub("\\, ",",",sTrain$Category)
sTrain$Category <- gsub("\\. ",".",sTrain$Category)
sTrain$Category <- gsub("\\,"," ",sTrain$Category)
sTrain$Category <- gsub("\\."," ",sTrain$Category)
sTrain$Category <- gsub(" & ","&",sTrain$Category)
sTrain$Category <- gsub("&"," and ",sTrain$Category)
sTrain$Category <- gsub(" - ","-",sTrain$Category)
sTrain$Category <- gsub("-"," - ",sTrain$Category)
sTrain$Category <- gsub("\\(","",sTrain$Category)
sTrain$Category <- gsub("\\)","",sTrain$Category)
sTrain$Category <- gsub("\\$","",sTrain$Category)
sTrain$Category <- gsub(" [ ]*"," ",sTrain$Category)

#Replacing some special entry
sTrain$Category <- gsub("aprntc statnry eng, sew plant","apprentice stationary engineer, sewage plant",sTrain$Category)
sTrain$Category <- gsub("aprntcstatnry eng,wtrtreatplnt","apprentice stationary engineer,water treatment pln",sTrain$Category)
sTrain$Category <- gsub("architectural assistant ","architectural assistant",sTrain$Category)
sTrain$Category <- gsub("architectural associate ","architectural associate",sTrain$Category)
sTrain$Category <- gsub("area sprv parks, squares & fac","area supervisor, parks, squares and facilities   ",sTrain$Category)
sTrain$Category <- gsub(" musm cnsrvt, aam"," museum conservator, asian art museum",sTrain$Category)
sTrain$Category <- gsub("asst chf prob ofc juv prob","asst chief probation officer-juvenile probation",sTrain$Category)
sTrain$Category <- gsub("asst chf bur clm invest & admin","asst chief bureau of claims invest & admin",sTrain$Category)

#Replacing common abbreviation
a <- c("mgr","manager","emerg","emergency","sprv","supervisor","supv","supervisor","spec","specialist","coord","coordinator","const","construction","asst","assistant")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("assoc","associate","chf","chief","clk","clerk","dir","director","dept","department","dist","district","atty","attorney","dept","department","dept)","department)")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("victim/wit","victim/witness","svcs","services","rnch","ranch","main tech","maintenance technician","engr","engineer","med","medical","rec","recreation")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("dep","deputy","wrk","worker","auto","automotive","bdcomm","board commission","mbr","member","bldg","building","building","buildings","bd/comm","board/commission","board/commission","board commission")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("capt","captain","invsgtn","investigation","district tech","distribution technician","sctry","secretary","cfdntl","confidential")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("prob","probation","ofc","officer","juv","juvenile","sew","sewage","eng","engineer","wtrtreat","water treatment","atty1","attorney","adlt","adult","probation of","probation officer")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("ca","city attorneys","comm","commander","div","division","sprv1","supervisor","court ad","court administrative")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("lab","laboratory","ct comp","court computer","app","applications","sys","systems","emp","employee","attry's","attorney's","trnst","transit","mech","mechanic")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("maint","maintenance","electr","electrical","ex assistant","executive assistant","ex director","executive director","govrnmt/publ","government public","insp","inspector")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("prg","program","cnslr","counselor","mta","municipal transportation agency","syst","systems","anl","analyst","spc","specialist","rep","representative","representative commander","representative commission","rights commander","rights commission")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)
a <- c("sr","senior","sup","supervising","supv","supervising","ofcr","officer")
sTrain$Category <- cleanStr(a,sTrain$Category)
rm(a)

#Making list based on edited job data
sTrain$Category <- as.factor(sTrain$Category)
l <- unique(sTrain$Category)
ll <- l
l <- as.character(l)

#Training Data
temp <- c(l[1],"Finance",l[2],"Finance",l[3],"Finance",l[9],"Administration",l[10],"Administration",l[11],"Administration",l[12],"Administration",l[13],"Administration",l[20],"Transportation",l[21],"Transportation",l[22],"Transportation",l[23],"Transportation",l[24],"Transportation",l[25],"Transportation")
temp <- c(temp,l[36],"Others",l[37],"Others",l[38],"Others",l[39],"Others",l[43],"Others",l[44],"Others",l[45],"Engineering",l[46],"Construction",l[47],"Environtment",l[54],"Construction",l[55],"Construction",l[56],"Construction",l[60],"Others",l[61],"Transportation")
temp <- c(temp,l[62],"Transportation",l[70],"Law",l[72],"Public Services",l[76],"Others",l[79],"Security",l[84],"Law",l[86],"Law",l[89],"Healthcare",l[96],"Energy",l[106],"Engineering",l[109],"Finance",l[111],"Security",l[114],"Law",l[121],"Law",l[122],"Law",l[123],"Law")
temp <- c(temp,l[124],"Others",l[125],"Others",l[134],"Services",l[135],"Services",l[137],"Services",l[139],"Services",l[140],"Science",l[143],"Public Services",l[144],"Public Services",l[154],"Science",l[155],"Construction",l[156],"Construction",l[166],"Construction",l[167],"Construction",l[168],"Construction")
temp <- c(temp,l[174],"Security",l[175],"Public Services",l[176],"Public Services",l[177],"Healthcare",l[178],"Healthcare",l[189],"Law",l[191],"Science",l[195],"Construction",l[200],"Construction",l[203],"Law",l[204],"Security",l[207],"Energy",l[212],"Science",l[219],"Environtment",l[228],"Law",l[229],"Engineering",l[230],"Engineering",l[233],"Engineering",l[234],"Engineering")
temp <- c(temp,l[235],"Law",l[236],"Law",l[242],"Healthcare",l[243],"Healthcare",l[244],"Healthcare",l[247],"Security",l[249],"Security",l[254],"Communication",l[255],"Communication",l[256],"Communication",l[257],"Communication",l[260],"Others",l[261],"Others",l[272],"Others",l[275],"Services",l[276],"Law",l[280],"Others",l[281],"Others")
temp <- c(temp,l[289],"Law",l[296],"Others",l[298],"Law",l[302],"Media",l[303],"Media",l[313],"Others",l[316],"Services",l[317],"Services",l[322],"Healthcare",l[328],"Security",l[329],"Security",l[330],"Security",l[331],"Transportation",l[332],"Transportation",l[336],"Law",l[339],"Security",l[345],"Healthcare",l[346],"Others",l[347],"Healthcare")
temp <- c(temp,l[351],"IT",l[358],"Law",l[359],"Law",l[361],"Law",l[367],"Administration",l[368],"Administration",l[371],"Engineering",l[372],"Engineering",l[374],"Energy",l[375],"Energy",l[376],"Energy",l[377],"Energy",l[381],"Energy",l[387],"Energy",l[388],"Energy",l[389],"Energy",l[393],"Healthcare",l[394],"Healthcare")
temp <- c(temp,l[399],"Human Resources",l[400],"Human Resources",l[401],"Human Resources",l[406],"Engineering",l[408],"Engineering",l[409],"Engineering",l[410],"Healthcare",l[411],"Environtment",l[412],"Environtment",l[417],"Environtment",l[427],"Others",l[428],"Others",l[429],"Others",l[430],"Others",l[431],"Others",l[432],"Others",l[433],"Others")
temp <- c(temp,l[437],"Public Services",l[438],"Public Services",l[439],"Public Services",l[443],"Finance",l[444],"Finance",l[445],"Finance")
temp <- c(temp,l[446],"Services",l[447],"Services",l[448],"Others",l[449],"Security",l[450],"Security",l[451],"Security",l[453],"Others",l[455],"Others",l[457],"Services",l[461],"Others",l[463],"Administration",l[464],"Administration")
temp <- c(temp,l[471],"Healthcare",l[472],"Healthcare",l[473],"Healthcare",l[476],"Healthcare",l[484],"Others",l[486],"Healthcare",l[487],"Healthcare",l[489],"Healthcare",l[491],"Services",l[492],"Others",l[496],"Human Resources",l[497],"Human Resources",l[500],"Engineering",l[505],"Security",l[506],"Security",l[507],"Security")
temp <- c(temp,l[513],"Security",l[521],"Administration",l[527],"Administration",l[529],"Business",l[530],"Business",l[533],"Engineering",l[534],"Engineering",l[537],"Human Resources",l[540],"Human Resources",l[541],"Human Resources",l[544],"IT",l[545],"IT",l[546],"IT",l[547],"IT")
temp <- c(temp,l[555],"Human Resources",l[556],"Human Resources",l[560],"Services",l[561],"Services",l[567],"Science",l[568],"Science",l[573],"Law",l[574],"Law",l[575],"Law",l[576],"Law",l[577],"Law",l[578],"Law",l[579],"Law",l[580],"Law",l[583],"Others",l[584],"Services",l[585],"Services",l[586],"Services")
temp <- c(temp,l[601],"Others",l[609],"Engineering",l[610],"Engineering",l[611],"Engineering",l[616],"Transportation",l[617],"Transportation",l[618],"Transportation",l[619],"Transportation",l[627],"Transportation",l[628],"Transportation",l[633],"Others",l[634],"Others",l[639],"Marketing",l[640],"Marketing")
temp <- c(temp,l[644],"Engineering",l[645],"Engineering",l[646],"Engineering",l[648],"Administration",l[650],"Administration",l[651],"Administration",l[652],"Administration",l[653],"Administration",l[654],"Administration",l[662],"Healthcare",l[666],"Media",l[667],"Media",l[668],"Media",l[669],"Media",l[672],"Media",l[673],"Media")
temp <- c(temp,l[678],"Healthcare",l[679],"Healthcare",l[680],"Healthcare",l[681],"Healthcare",l[683],"Healthcare",l[684],"Healthcare",l[688],"Others",l[691],"Others",l[701],"Others",l[702],"Others",l[703],"Others",l[704],"Others",l[708],"Healthcare",l[709],"Healthcare",l[710],"Healthcare")
temp <- c(temp,l[718],"Others",l[719],"Others",l[720],"Others",l[721],"Others",l[725],"Services",l[726],"Services",l[727],"Services",l[728],"Services",l[729],"Services",l[736],"Others",l[739],"Others",l[740],"Others",l[745],"Others",l[746],"Others",l[747],"Others",l[748],"Others",l[749],"Others",l[750],"Others",l[755],"Healthcare",l[756],"Healthcare",l[757],"Healthcare")
temp <- c(temp,l[758],"Others",l[759],"Healthcare",l[760],"Healthcare",l[761],"Healthcare",l[762],"Science",l[763],"Science",l[764],"Art",l[766],"Others",l[767],"Others",l[768],"Others",l[769],"Others",l[770],"Environtment",l[771],"Environtment",l[772],"Environtment",l[773],"Environtment")
temp <- c(temp,l[776],"Construction",l[777],"Construction",l[780],"Security",l[781],"Security",l[782],"Others",l[783],"Others",l[784],"Others",l[785],"Others")
temp <- c(temp,l[787],"Energy",l[788],"Energy",l[789],"Energy",l[790],"Energy",l[791],"Energy",l[792],"Energy",l[793],"Public Relations",l[794],"Public Relations",l[795],"Public Relations",l[796],"Public Relations",l[797],"Public Relations",l[798],"Public Relations",l[803],"Finance",l[805],"Administration",l[806],"Engineering",l[807],"Others",l[809],"Environtment",l[811],"Environtment")
temp <- c(temp,l[822],"Properties",l[823],"Properties",l[824],"Others",l[827],"Law",l[828],"IT",l[829],"IT",l[830],"IT",l[832],"Properties",l[838],"Healthcare",l[839],"Healthcare",l[842],"Law",l[844],"Healthcare",l[847],"Public Relations",l[848],"Public Relations",l[849],"Public Relations",l[850],"Security",l[851],"Security",l[852],"Public Services",l[853],"Public Services",l[854],"Public Services",l[855],"Public Services")
temp <- c(temp,l[856],"Public Services",l[857],"Public Services",l[858],"Public Services",l[864],"Others",l[868],"Properties",l[869],"Properties",l[870],"Properties",l[871],"Properties",l[872],"Services",l[873],"Services",l[879],"Others",l[880],"Others",l[881],"Others",l[882],"Others",l[883],"Others",l[884],"Others",l[885],"Science",l[886],"Science",l[887],"Science",l[890],"Others",l[898],"Others",l[899],"Others",l[900],"Others",l[901],"Others",l[902],"Others",l[903],"Others")
temp <- c(temp,l[909],"Finance",l[911],"Administration",l[912],"Transportation",l[916],"Construction",l[920],"Others",l[928],"Services",l[930],"Security",l[932],"Energy",l[938],"Engineering",l[939],"Environtment",l[944],"Services",l[947],"Healthcare",l[954],"Others",l[955],"Others",l[956],"Others",l[957],"Others",l[958],"Others",l[959],"Others",l[961],"Healthcare",l[963],"Science",l[966],"Others",l[967],"Others",l[968],"Healthcare")
temp <- c(temp,l[971],"Services",l[977],"Others",l[978],"Healthcare",l[979],"Healthcare",l[980],"Science",l[984],"Energy",l[985],"Energy",l[986],"Properties",l[992],"Properties",l[993],"Properties",l[995],"Engineering",l[996],"Construction",l[997],"Environtment",l[998],"Others",l[1003],"Communication",l[1010],"Security",l[1011],"Security",l[1012],"Environtment",l[1013],"Environtment",l[1014],"Engineering",l[1015],"Engineering")
temp <- c(temp,l[1018],"Manufacture",l[1019],"Manufacture",l[1020],"Manufacture",l[1021],"Others",l[1022],"Others",l[1023],"Others",l[1024],"Others",l[1026],"Security",l[1027],"Security",l[1028],"Security",l[1029],"Security",l[1030],"Security",l[1036],"Public Services",l[1037],"Public Services",l[1038],"Public Services",l[1039],"Others",l[1040],"Others",l[1041],"Others",l[1042],"Others",l[1043],"Others",l[1044],"Others",l[1045],"Others",l[1046],"Others")
temp <- c(temp,l[1052],"Law",l[1054],"Healthcare",l[1055],"Energy",l[1058],"Transportation",l[1059],"Transportation",l[1064],"Others",l[1065],"Others",l[1067],"Others",l[1068],"Others",l[1069],"Others",l[1070],"Energy",l[1075],"Environtment",l[1076],"Others",l[1078],"Others",l[1079],"Energy",l[1083],"Construction",l[1084],"Engineering",l[1085],"Environtment",l[1086],"Science",l[1091],"Others",l[1094],"Others")
temp <- c(temp,l[1095],"Others",l[1098],"Environtment",l[1099],"Transportation",l[1100],"Transportation",l[1101],"Transportation",l[1106],"Others",l[1107],"Others",l[1111],"Finance",l[1112],"Science",l[1114],"Science",l[1120],"Healthcare",l[1123],"Others",l[1125],"Others",l[1128],"Science")
temp <- c(temp,l[1132],"Others",l[1133],"Others",l[1139],"Communication",l[1140],"Communication",l[1141],"Communication",l[1143],"Healthcare",l[1145],"Others",l[1146],"Others",l[1147],"Others",l[1150],"Transportation",l[1151],"Transportation",l[1155],"Transportation")
temp <- c(temp,l[1156],"Human Resources",l[1157],"Human Relations",l[1159],"Transportation",l[1160],"Transportation",l[1161],"Others",l[1162],"Transportation",l[1163],"Transportation",l[1164],"Transportation",l[1165],"Transportation",l[1170],"Transportation",l[1171],"Transportation",l[1172],"Energy",l[1173],"Energy",l[1174],"Energy",l[1178],"Communication",l[1180],"Transportation",l[1182],"Others",l[1183],"Others",l[1184],"Others")
temp <- c(temp,l[1187],"Security",l[1189],"Others",l[1190],"Others",l[1191],"Others",l[1192],"Others",l[1196],"Others",l[1202],"Others",l[1205],"Environtment",l[1206],"Environtment",l[1209],"Environtment",l[1210],"Environtment",l[1214],"Environtment",l[1215],"Environtment",l[1216],"Environtment",l[1217],"Environtment",l[1221],"Others",l[1224],"Services",l[1227],"Others",l[1228],"Others",l[1231],"Healthcare")
temp <- c(temp,l[1232],"Others",l[1233],"Others",l[1234],"Others")
temp <- splitData(temp)
rm(l)
#526 Training Data

#Removing training data from original list (tl -> Test List)
trainer <- temp
rm(temp)
tl <- removeData(trainer,ll)
tl <- as.factor(as.character(tl))
rm(ll)

#Making test data frame and Adding dummy Category data to it
test <- data.frame(Job = tl, Category = "X") 

#Merging test and train data frame(tt -> Train and Test)
tt <- data.frame(Job = c(as.character(trainer[,1]),as.character(test[,1])), Category = c(as.character(trainer[,2]),as.character(test[,2])))
copytt <- tt[-c(2)] #used for Document-Term Matrix
rm(test)

#Document-Term Matrix (Term Frequency - Inverse Document Frequency weighting)
mat <- create_matrix(copytt, language="english", removeNumbers=FALSE, stemWords=FALSE, removePunctuation=FALSE, weighting=weightTfIdf)
rm(copytt)

#Container (formatting test and train data to be used for predicting)
con <- create_container(mat,t(tt[2]),trainSize=1:526, testSize=527:1234,virgin=FALSE)
rm(tt)

#Models and Prediction
mod <- train_models(con, algorithms=c("TREE","MAXENT","SVM","SLDA","BAGGING","BOOSTING"))
pred <- classify_models(con, mod)

#Check for Least Others from Prediction Result
length(grep("Others",pred[,1]))
length(grep("Others",pred[,3]))
length(grep("Others",pred[,5]))
length(grep("Others",pred[,7]))
length(grep("Others",pred[,9]))
length(grep("Others",pred[,11]))

#Brief manual check for accuraccy
data.frame(tl,pred[,1],pred[,2])
data.frame(tl,pred[,3],pred[,4]) #LEAST OTHERS
data.frame(tl,pred[,5],pred[,6])
data.frame(tl,pred[,7],pred[,8]) #SEEMS ACCURATE
data.frame(tl,pred[,9],pred[,10]) #TOO MANY OTHERS
data.frame(tl,pred[,11],pred[,12])

#MAXENT Algorithm is Chosen
#Manual Checking for Wrong Category
t <- c(2,5,8,9,21,29,30,39,40,68,69,70,75,76,90,91,97,99,100,101,106,107,108,109,117,119,120,125,127,130,140,144,145,155,156,163,165,166,167,168,170,175,176,177,180,181,182,190,196,200)
t <- c(t,206,209,213,216,217,219,222,225,230,236,240,243,245,246,247,257,259,262,263,264,265,267,268,269,277,285,286,289,297,298)
t <- c(t,301,305,306,311,318,319,320,321,322,324,327,331,332,336,346,347,350,351,352,353,354,355,356,357,358,359,360,372)
t <- c(t,409,422,434,436,442,443,454,458,464,466,468,469,471,472,473,474,478,479,490)
t <- c(t,502,506,508,511,521,524,530,539,542,543,544,547,548,550,551,553,554,561,563,569,571,576,577,583,584,588,590,592,593,594,595)
t <- c(t,602,613,617,618,619,622,623,630,632,633,634,644,650,659,662,664,665,666,670,675,676,682,690,693,704)

#MAXENT Result and Applying Manual Check Result
result <- data.frame(Job = tl,Category = pred[,3])
result[t,2] = "Others"
rm(t,tl)

#Complete Job and Category Data Frame
complete <- data.frame(Job = c(as.character(trainer[,1]),as.character(result[,1])), Category = c(as.character(trainer[,2]),as.character(result[,2])))

#Merging to main data frame
sTrain$Category <- as.character(sTrain$Category)
complete$Job <- as.character(complete$Job)
complete$Category <- as.character(complete$Category)

#Minor Tweak for gsub() Function
complete$Job <- gsub("\\$"," ",complete$Job)
sTrain$Category <- gsub("\\$"," ",sTrain$Category)

for (i in 1:(length(complete$Job))) {
	rep <- paste("^",complete$Job[i],"$",sep = "")
	sTrain$Category <- gsub(rep,complete$Category[i],sTrain$Category)
	rm(rep)
}
rm(i)

#Making Frequency Table
frequency = as.data.frame(table(sTrain$Category))
names(frequency)[1] = "Category"
frequency
str(frequency)

#Writing Modified Data into csv and png
sTrain <- sTrain[order(sTrain$Id),]
ggsave("Classification.png",plot = ggplot(frequency, aes(factor(Category), y = Freq, fill=Category)) + geom_bar(stat="identity", position = "dodge") + ggtitle("Frequency Based on Category") + labs(x = "Category", y="Frequency") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size=6)))
write.csv(sTrain,file="Classification.csv")