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

input int atrStp = 2;
double SMA10a, SMA10b, SMA40a, SMA40b, atr, stop, accountProfit;
int ordenAbierta;
int ordenCobertura;
TradeManager trader;
OrderInfo info;
bool cobertura = false;
bool cierreCobertura = false;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   SMA10a = iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 1);
   SMA10b = iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 2);
   SMA40a = iMA(NULL, 0, 40, 0, MODE_SMA, PRICE_CLOSE, 1);
   SMA40b = iMA(NULL, 0, 40, 0, MODE_SMA, PRICE_CLOSE, 2);
   atr = iATR(NULL, 0, 14, 0);

   stop = atr * Point ;

//entrada
   if(OrdersTotal() == 0 && !cobertura)
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
   if(OrdersTotal() == 1 && info.profitOrder(ordenAbierta) < -2 && !cobertura)
     {
      cobertura = true;
      cierreCobertura = true;
      if(info.TypeOrder(ordenAbierta) == "OP_BUY")
        {
         ordenCobertura = trader.Sell(0.01, 200, 200);
         trader.TGRPriceModifier(ordenAbierta, info._openPrice(ordenAbierta));
         //trader.Buy(0.02, 100, 200);
        }
      if(info.TypeOrder(ordenAbierta) == "OP_SELL")
        {
         ordenCobertura = trader.Buy(0.01, 200, 200);
         trader.TGRPriceModifier(ordenAbierta, info._openPrice(ordenAbierta));
         //trader.Sell(0.02, 100, 200);
        }
     }
   if(AccountProfit() > -0.5 && cobertura && OrdersTotal() == 2)
     {
      trader.CloseOrder(ordenAbierta);
      trader.CloseOrder(ordenCobertura);
      
      cobertura = false;
     }
   
   // cierre por cobertura
   if(cierreCobertura && info.IsClose(ordenCobertura))
     {
      trader.CloseOrder(ordenAbierta);
      cierreCobertura = false;
      cobertura = false;
     }
   Comment("OrdenAbierta: ", ordenAbierta, " Profit: ", info.profitOrder(ordenAbierta), " Order Type: ", info.TypeOrder(ordenAbierta), "\n",
           "OrdenCobertura: ", ordenCobertura, " Profit: ", info.profitOrder(ordenCobertura), " Order Type: ", info.TypeOrder(ordenCobertura), "\n",
           "Accoun Balance: ", AccountBalance(), " Account Profit: ", AccountProfit(), "\n",
           "Cobertura? ", cobertura, "\n",
           "Orders Total: ", OrdersTotal());

//Salida
   if(OrdersTotal() == 1 && !cobertura)
     {
      if(info.TypeOrder(ordenAbierta) == "OP_BUY")
        {
         if(SMA10b > SMA40b && SMA10a < SMA40a)
           {
            trader.CloseOrder(ordenAbierta);
           }
        }
      if(info.TypeOrder(ordenAbierta) == "OP_SELL")
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
//+------------------------------------------------------------------+
