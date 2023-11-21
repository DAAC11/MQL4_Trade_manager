//+------------------------------------------------------------------+
//|                                                  Bryan2Gap2C.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property strict
#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"


input double gap = 0.000001;
input int atrSTP =2;
input int atrTGR =5;
int ordenAbierta;
TradeManager trader;
OrderInfo info;
double diff, atr, stop, target;
void OnTick()
  {
   atr = iATR(NULL, 0, 14, 0);
   stop = Close[0] - atr * atrSTP;
   target = Close[0] + atr * atrTGR;
   diff =  MathAbs(Close[3] - Open[2]);
   if(OrdersTotal() == 0)
     {
      if(diff > gap && Close [3] > Open[2] && Close[2] > Open[2] && Close[1] > Open[1])
        {
         ordenAbierta = trader.Buy(75);
         trader.STPPriceModifier(ordenAbierta, stop);
         trader.TGRPriceModifier(ordenAbierta, target);
        }
     }
   Comment("\nATR: " + atr +
           "\n: " + atr);
  }
//+------------------------------------------------------------------+
