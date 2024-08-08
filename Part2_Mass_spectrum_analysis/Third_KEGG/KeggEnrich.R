install.packages("BiocManager")
library(BiocManager)
BiocManager::install("AnnotationDbi")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("clusterProfiler")

library(AnnotationDbi)
library(org.Mm.eg.db)
library(clusterProfiler)

head(keys(org.Hs.eg.db,keytype = "PMID"))

musKEGGID<-read.table("clipboard",header = F)
musUniprotID<-read.table("clipboard",header = F)
musNCBI<-read.table("clipboard",header = F)
musNCBI<-substring(musNCBI[,1],13)
musEntrezID<- bitr(musUniprotID[,1], fromType="UNIPROT",toType=c("ENTREZID","SYMBOL"), OrgDb="org.Mm.eg.db")


####  ENRICH  ####

###  KEGG enrichment using uniprot ID
kegg_IDuniprot<-enrichKEGG(musUniprotID[,1],
                           organism = "mmu",
                           keyType = "uniprot",
                           pAdjustMethod = "BH",
                           pvalueCutoff = 0.05)
#"Vascular smooth muscle contraction" 136/278

barplot(kegg_IDuniprot,showCategory = 150,title = "The KEGG enrichment analysis")

###  KEGG enrichment using entrez ID
kegg_IDEntrez<-enrichKEGG(musNCBI,
                           organism = "mmu",
                           keyType = "ncbi-geneid",
                           pAdjustMethod = "BH",
                           pvalueCutoff = 0.05)
#"Vascular smooth muscle contraction" 125/289

barplot(kegg_IDEntrez,showCategory = 150,title = "The KEGG enrichment analysis")

###  KEGG enrichment using kegg ID
kegg_IDkegg<-enrichKEGG(substring(musKEGGID[,1],5),
                          organism = "mmu",
                          keyType = "kegg",
                          pAdjustMethod = "BH")
#"Vascular smooth muscle contraction" 125/289
dotplot(kegg_IDkegg,showCategory = 150,title = "The KEGG enrichment analysis")

###  GO enrichment using entrez ID
go_IDEntrez<-enrichGO(musNCBI,
                    OrgDb = org.Mm.eg.db,
                    keyType = "ENTREZID",
                    pAdjustMethod = "BH",
                    pvalueCutoff = 0.05,
                    ont="BP")
barplot(kegg_IDEntrez,showCategory = 150,title = "The KEGG enrichment analysis")

kegg_result<-(as.data.frame(kegg_IDkegg@result))
write.table(kegg_result,file = "E:/醉梦不醒A/Westlake/JiaLab_outsider/Jiayu_enrich/kegg_res.txt",sep = "\t",quote = F,row.names = F)
save.image("E:/醉梦不醒A/Westlake/JiaLab_outsider/Jiayu_enrich/enrich_res.RData")


#### Plot  ####
rm(list = ls())
kegg_res<-read.delim("E:/醉梦不醒A/Westlake/JiaLab_outsider/Jiayu_enrich/kegg_res.txt",header = T)

#kegg_plot<-kegg_res[1:150,]
kegg_plot<-kegg_res[order(kegg_res$p.adjust),][1:150,]    ##提取显著性前150的通路绘图
top150<-data.frame("Description"=kegg_plot$Description,"count"=kegg_plot$Count,"padj"=kegg_plot$p.adjust)

##barplot
p<-ggplot(data = top150,aes(x=Description,y=count,fill=padj))
p1<-p+geom_bar(stat="identity")+ coord_flip()
p2 <- p1 + theme(panel.background=element_rect(fill='transparent',color='gray'),
                 axis.text.y=element_text(color="black",size=12))
#ylim(0,65) 更改横坐标的范围这里坐标轴颠倒了，虽然看起来是x轴，但其实是y轴
p3 <- p2 + ylim(0,65) + scale_fill_gradient(low="red",high="blue")
p4 <- p3 + scale_x_discrete(limits=rev(top150[,1])) +labs(x="",y="",title="KEGG")
p4


###Dotplot
ggplot(top150,aes(y=Description,x=count))+geom_point()+geom_point(aes(size=count,color=padj))+
  scale_color_gradient(low="red",high = "blue")+
  labs(x="Pvalue",y="Pathways",title = "KEGG Pathway Enrichment")


