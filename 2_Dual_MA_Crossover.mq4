//+------------------------------------------------------------------+
//|                                          2_Dual_MA_Crossover.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"


double SMA10a, SMA10b, SMA40a, SMA40b;
int ordenAbierta;
TradeManager trader;
OrderInfo info;
void OnTick()
  {
   SMA10a = iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 1);
   SMA10b = iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 2);
   SMA40a = iMA(NULL, 0, 40, 0, MODE_SMA, PRICE_CLOSE, 1);
   SMA40b = iMA(NULL, 0, 40, 0, MODE_SMA, PRICE_CLOSE, 2);

//entrada
   if(OrdersTotal() == 0)
     {
      if(SMA10b < SMA40b && SMA10a > SMA40a)
        {
         ordenAbierta = trader.Buy(0.01);
        }
      if(SMA10b > SMA40b && SMA10a < SMA40a)
        {
         ordenAbierta = trader.Sell(0.01);
        }
     }
       

//Salida
   if(OrdersTotal() == 1)
     {
      if(info.TypeOrder(ordenAbierta)=="OP_BUY")
        {
         if(SMA10b > SMA40b && SMA10a < SMA40a)
           {
            trader.CloseOrder(ordenAbierta);
           }
        }
      if(info.TypeOrder(ordenAbierta)=="OP_SELL")
        {
         if(SMA10b < SMA40b && SMA10a > SMA40a)
           {
            trader.CloseOrder(ordenAbierta);
           }
        }
     }

  }
//+------------------------------------------------------------------+
/*
   Como lo dice en el libro da un 44% de acierto 
*/