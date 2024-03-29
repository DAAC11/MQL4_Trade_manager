//+------------------------------------------------------------------+
//|                                             4_StdDevX2Signal.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"
input int momentumPeriods = 20;
TradeManager trader;
OrderInfo info;
int openTrade;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   // Calcula la desviación estándar de los últimos 100 precios de cierre
   double stdDev = iStdDev(Symbol(), Period(), 100, 0, MODE_SMA, PRICE_CLOSE, 0);

   // Calcula el rango de precio en la vela actual
   double priceRange = High[1] - Low[1];

   // Compara el rango de precio con el doble de la desviación estándar
   if(priceRange >= 2.0 * stdDev && OrdersTotal() == 0)
     {
      if(Close[1] > Close[2])
        {
         openTrade = trader.Buy(0.01);
        }
      if(Close[1] < Close[2])
        {
         openTrade = trader.Sell(0.01);
        }
     }
   if(priceRange >= 2.0 * stdDev && OrdersTotal() == 1)
     {
      if(Close[1] > Close[2] && info.TypeOrder(openTrade) == "OP_SELL")
        {
         trader.CloseOrder(openTrade);
        }
      if(Close[1] < Close[2] && info.TypeOrder(openTrade) == "OP_BUY")
        {
         trader.CloseOrder(openTrade);
        }
     }
   Comment("\nStdDesv: " + stdDev +
           "\npriceRange: " + priceRange);
   
   
     
     
     
  }
//+------------------------------------------------------------------+
/*
   No da entradas debe tener algun error el codigo o el planteamiento
   ]

*/