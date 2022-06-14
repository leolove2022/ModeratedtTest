library(BiocManager)
library(openxlsx)
library(limma)
library(MKmisc)


address_data_ProteinCelltype_input="2022_05_25_DIA132re_Proteins_Filtered analyzed_filter3_2170.xlsx"
data_ProteinCelltype=read.xlsx( address_data_ProteinCelltype_input, rowNames = F,colNames = T)
data_normalized_1<-data_ProteinCelltype[,7:12]
data_normalized_2<-data.matrix(data_normalized_1, rownames.force =NA)
data_normalized_2_nor<-scale(data_normalized_2, center =TRUE, scale=TRUE)
data_normalized_2_nor.frame<-as.data.frame(data_normalized_2_nor)
data_ProteinCelltype_2<-cbind(data_ProteinCelltype,data_normalized_2_nor.frame)

address_data_ProteinCelltype_normal_output<-"2022_05_25_DIA132re_Proteins_Filtered analyzed_filter3_2170_nor.csv"
write.csv(data_ProteinCelltype_2,file=address_data_ProteinCelltype_normal_output,row.names=FALSE)
#manually change the nor colume name end with.nor
address_data_ProteinCelltype_normal_input<-"2022_05_25_DIA132re_Proteins_Filtered analyzed_filter3_2170_nor.xlsx"
data_ProteinCelltype_2<-read.xlsx( address_data_ProteinCelltype_normal_input, rowNames = F,colNames = T)
data_moderated_nor<-as.data.frame(data_ProteinCelltype_2[,22:27])
data_moderated_nor_2=data.matrix(data_moderated_nor)
g2 <- factor(c(rep("sed", 3), rep("run", 3)))
data_moderated_nor_2_t=mod.t.test(data_moderated_nor_2, group = g2)
data_moderated_nor_3<-cbind(data_ProteinCelltype_2,data_moderated_nor_2_t)
# save the final Moderated T test result
address_data_ProteinCelltype_moderatedTTest_output<-"2022_05_25_DIA132re_Proteins_Filtered analyzed_filter3_2170_nor_moderated.csv"
write.csv(data_moderated_nor_3,file=address_data_ProteinCelltype_moderatedTTest_output,row.names=FALSE)

