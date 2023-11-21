//+------------------------------------------------------------------+
//|                                                        Bryan.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "\\Class\\TradeManager.mqh"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

double EMA20;
double EMA40;
double EMA20b;
double EMA40b;

TradeManager tm;
void OnTick()
  {
//---
   EMA20 = iMA(NULL,0,20,0,MODE_EMA,PRICE_CLOSE,1);
   EMA40 = iMA(NULL,0,40,0,MODE_EMA,PRICE_CLOSE,1);
   EMA20b = iMA(NULL,0,20,0,MODE_EMA,PRICE_CLOSE,2);
   EMA40b = iMA(NULL,0,40,0,MODE_EMA,PRICE_CLOSE,2);
   if(OrdersTotal()==0)
     {
      if(EMA20b<EMA40b&&EMA20>EMA40)
        {
         if(Close[1]>EMA20)
           {
           
            tm.Buy(0.01,1000,100);
           }

        }
      if(EMA20b>EMA40b && EMA20<EMA40)
        {
         if(Close[1]<EMA20)
           {
            tm.Sell(0.01,500,100);
           }

        }
     }

  }
