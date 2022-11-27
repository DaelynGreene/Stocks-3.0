library(rvest)
library(gmailr)

rm(list = ls())

if(format(Sys.time(), "%H") == 20 && format(Sys.time(),"%M") %in% c(20:40))
{

FirstTrustCPST61 <- "https://www.ftportfolios.com/retail/dp/dpsummary.aspx?fundid=16790"

PriceWebsiteCPST61 <- session(FirstTrustCPST61)

PriceCPST61 <- PriceWebsiteCPST61 %>%
  html_element("#ContentPlaceHolder1_Dpsummary1_lblNAV") %>%
  html_text2()

PriceCPST61 <- gsub("[$]","",PriceCPST61)

PriceCPST61 <- as.numeric(PriceCPST61)

DepositAmount <- 6000

NumberOfShares <- 563 #HOW TO UPDATE THIS???????????????????????????????

Dividend <- #scrub first trust's table the 10th of june and december, that should have it

FreeCash <- 4.78  
  
SharesWorth <- PriceCPST61 * NumberOfShares

TotalAccountWorth <- SharesWorth + FreeCash

PercentChange <- 100*(TotalAccountWorth - DepositAmount)/DepositAmount

if (format(Sys.Date(), "%m") %in% c(06,12) && format(Sys.Date(), "%d") == 10){

FirstTrustCPST61Dist <- "https://www.ftportfolios.com/Retail/dp/dpdistributions.aspx?fundid=16790"

DividendHarvesterSession <- session(FirstTrustCPST61Dist)

}






# NoClueHowThisWorks <- GuineaPig %>% 
#   html_table()
# 
# TEST <- NoClueHowThisWorks[[1]]
# 
# FirstDividendPayment <- as.numeric(gsub("[$]","",TEST$X55[1]))





gm_auth_configure("606976777155-8q918leqmsjiphi07i2nb4rk34het5q8.apps.googleusercontent.com","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")
gm_auth(email = "patbackthebackpack@gmail.com")

gm_send_message(
 gm_mime() %>%
  gm_from("patbackthebackpack@gmail.com") %>%
  gm_to("daelyn.greene865@gmail.com") %>%
  gm_subject(paste("Daily Summary for",Sys.Date())) %>%
  gm_text_body(paste("The closing price of Series 61 was",paste0(PriceCPST61,"."),"The current Roth worth is",paste0("$",round(TotalAccountWorth,2),"."),"The current Roth percent change is",paste0(round(PercentChange,3),"%",".")))
)


# If (weekdays(Sys.Date()) == "Sunday") {
# } else if (weekdays(Sys.Date()) %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday") {


} else {
  gm_auth_configure("606976777155-8q918leqmsjiphi07i2nb4rk34het5q8.apps.googleusercontent.com","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")
  gm_auth(email = "patbackthebackpack@gmail.com")
  
  gm_send_message(
    gm_mime() %>%
      gm_from("patbackthebackpack@gmail.com") %>%
      gm_to("newestestemail@gmail.com") %>%
      gm_subject("Ignore me this is the test") %>%
      gm_text_body("the current time is who cares")
  )
}
