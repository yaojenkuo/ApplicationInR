# How to Visualize the Asset of Political Parties in Taiwan using R
Yao-Jen Kuo  
Sunday, December 27, 2015  

# Introduction

TVBS published a news on 2015/12/24 20:59(updated 2015/12/25 20:50) __選前再追黨產! 綠拚國會過半立政黨法__ and use Bar Chart as a visualization to compare properties between political parties. The screenshot was widely-spreaded online:

![Screenshot of TVBS News](tvbs.jpg)

This article introduces how to visualize the asset of political parties in Taiwan using R __CORRECTLY__.

---

# Data

The data is from [內政部民政司103 年政黨財務申報](http://www.moi.gov.tw/dca/03caucus_10301.aspx), and only 4 parties authenticated their financial reports via accounting firm : KMT, DPP, PFP, and TSU.


```r
Sys.setlocale(category = "LC_ALL", locale = "cht")
parties <- c("KMT", "DPP", "PFP", "TSU")
assetInMillionNTD <- c(25570, 479, 3, 21)
color <- c("blue", "green", "orange", "goldenrod")
partiesAsset <- data.frame(parties, assetInMillionNTD, color)
```

---

# Packages

This article would visualizae the properties in 3 ways, and **Base Plotting System** is the built-in graph function of R, hence there is no need to install/load packages before plotting. However, you would have to install/load packages before using __ggplot2__ and __plotly__.

* Base Plotting System
* ggplot2


```r
#install.packages("ggplot2")
library(ggplot2)
```

* plotly


```r
#install.packages("plotly")
library(plotly)
```

---

# Visualization

* Base Plotting System


```r
basebp <- barplot(partiesAsset$assetInMillionNTD, names.arg=partiesAsset$parties, col=color, cex.names=0.8, border=NA, ylim=c(0,30000), main=paste("民國103年政黨財務申報(具會計師簽證)","\n","單位:新台幣百萬元"), sub="資料來源:內政部民政司")
text(x=basebp, y=partiesAsset$assetInMillionNTD, label=partiesAsset$assetInMillionNTD, pos = 3, cex = 0.8)
```

![](assetsPartiesTW_files/figure-html/unnamed-chunk-4-1.png) 

* ggplot2


```r
ggplotbp <- ggplot(data=partiesAsset, aes(x=parties, y=assetInMillionNTD))+geom_bar(colour=NA, fill=c("green", "blue", "orange", "goldenrod"), width=.8, stat="identity")+ ggtitle(paste("民國103年政黨財務申報(具會計師簽證)","\n","單位:新台幣百萬元"))+ylab("")+xlab("資料來源:內政部民政司")+geom_text(aes(label=assetInMillionNTD), vjust = -0.5)
ggplotbp
```

![](assetsPartiesTW_files/figure-html/unnamed-chunk-5-1.png) 

* plotly


```r
plotlybp <- plot_ly(
  x=parties,
  y=assetInMillionNTD,
  type="bar",
  marker=list(color = c(toRGB("blue"), toRGB("green"), toRGB("orange"), toRGB("goldenrod")))
  )
plotlybp %>%
  layout(xaxis=list(title='Source: Department of Civil Affairs'),
         yaxis=list(title=''),
         title='Asset of Political Parties in Taiwan(in NTD million)'
         )
```

<!--html_preserve--><div id="htmlwidget-4596" style="width:672px;height:480px;" class="plotly"></div>
<script type="application/json" data-for="htmlwidget-4596">{"x":{"data":[{"type":"bar","inherit":true,"x":["KMT","DPP","PFP","TSU"],"y":[25570,479,3,21],"marker":{"color":["rgb(0,0,255)","rgb(0,255,0)","rgb(255,165,0)","rgb(218,165,32)"]}}],"layout":{"xaxis":{"title":"Source: Department of Civil Affairs"},"yaxis":{"title":""},"title":"Asset of Political Parties in Taiwan(in NTD million)","margin":{"b":40,"l":60,"t":25,"r":10}},"url":null,"width":null,"height":null,"base_url":"https://plot.ly","layout.1":{"xaxis":{"title":"Source: Department of Civil Affairs"},"yaxis":{"title":""},"title":"Asset of Political Parties in Taiwan(in NTD million)"},"filename":"Asset of Political Parties in Taiwan(in NTD million)"},"evals":[]}</script><!--/html_preserve-->

# Appendix: Treemap

Instead of Bar Charts, it is also popular to use __Treemap__ to visualize the data.


```r
#install.packages("treemap")
library(treemap)
treemap(partiesAsset
, index = "parties"
, vSize = "assetInMillionNTD"
, type="value"
, title= "Asset of Political Parties in Taiwan(in NTD million)"
, palette="RdBu"
)
```

![](assetsPartiesTW_files/figure-html/unnamed-chunk-7-1.png) 

---
