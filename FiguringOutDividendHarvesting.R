StartTime <- Sys.time()

library(quantmod)
library(dplyr)

SYMBOLS <- stockSymbols()

SYMBOLS <- SYMBOLS %>% 
  mutate(SYMBOLNAMECOMBO = paste(Symbol,"-",Name))

SYMBOLS <- SYMBOLS %>% 
  subset(Exchange %in% c("NASDAQ","NYSE"),
         select = -c(Industry,Sector,IPOyear,MarketCap,LastSale,Next.Shares,ACT.Symbol,CQS.Symbol,NASDAQ.Symbol,Round.Lot.Size,Test.Issue,Market.Category))

SYMBOLS <- SYMBOLS %>% 
  mutate(DIVIDENDINFO = 0)

SYMBOLS <- SYMBOLS %>% 
  mutate(PRICE = 0)

SYMBOLS <- SYMBOLS[-grep("warrant",SYMBOLS$Name,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("right",SYMBOLS$Name,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("unit",SYMBOLS$Name,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("warrrant",SYMBOLS$Name,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("file creation time",SYMBOLS$Symbol,ignore.case = T),]

##### THE FOLLOWING GREPS ARE ONLY HERE BECAUSE OF RECENT IPOS, EVENTUALLY THEY WILL NEED TO BE DELETED ONCE IT CAN HANDLE THEM (TIMEFRAME???????)

SYMBOLS <- SYMBOLS[-grep("back",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("flfv",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("byob",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("conl",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("tbil",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("tsl",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("tweb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("uten",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("utwo",SYMBOLS$Symbol,ignore.case = T),]

##### I DONT KNOW WHAT YOU ARE, SO MAY OR MAY NOT EVER BE ABLE TO INCLUDE YOU

SYMBOLS <- SYMBOLS[-grep("aapb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("aapd",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("aapu",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("acac",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("dhcnl",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("whlrl",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zazzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zbzzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zczzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zfox",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zjzzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zvzzc",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zvzzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zwzzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zxyz-a",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("zxzzt",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("acp-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("adc-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("abr-pf",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("bc-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("bc-pb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("bc-pc",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("cbo",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("cbx",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("cno-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("ctest",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("f-pb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("f-pc",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("fbrt-pe",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("fhn-pb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("fhn-pc",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("fhn-pd",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("frc-pl",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("gl-pd",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("ms-pp",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("mtb-ph",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("ncz-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("nee-pn",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("ntest",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("pbi-pb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("prif-pg",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("prif-pj",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("rc-pc",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("rjf-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("sfb",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("tds-pu",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("trtn-pd",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("vno-pn",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wbs-pg",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wcc-pa",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wrb-pe",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wrb-pf",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wrb-pg",SYMBOLS$Symbol,ignore.case = T),]
SYMBOLS <- SYMBOLS[-grep("wrb-ph",SYMBOLS$Symbol,ignore.case = T),]

PriceInfo <- c()
THE <- c()
URLBeginning <- 

for (i in 1:nrow(SYMBOLS)){
  PriceInfo <- getSymbols(SYMBOLS$Symbol[i],auto.assign = F)
  SYMBOLS$PRICE[i] <- PriceInfo[nrow(PriceInfo),4]
}

EndTime <- Sys.time()

EndTime-StartTime

# for (i in 1:nrow(SYMBOLS)){
#   
#   if(length(getDividends(SYMBOLS$Symbol[i],from = Sys.Date()-100,to = Sys.Date())) != 0){
#     THE <- getDividends(SYMBOLS$Symbol[i],from = Sys.Date()-100,to = Sys.Date())
#     SYMBOLS$DIVIDENDINFO[i] <- THE[nrow(THE),1]
#   }
#   
# }







