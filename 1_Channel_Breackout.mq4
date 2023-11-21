//+------------------------------------------------------------------+
//|                                          1_Channel_Breackout.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
double upperBand0;
double upperBand1;
double upperBand2;
double upperBand201;
double lowerBand0;
double lowerBand1;
double lowerBand2;

string control;

int OrdenAbierta;
TradeManager trader;
OrderInfo info;
void OnTick()
{
   upperBand0 = iCustom(NULL, 0, "MaxNPeriods", 40, 0, 0);
   upperBand1 = iCustom(NULL, 0, "MaxNPeriods", 40, 0, 1);
   upperBand2 = iCustom(NULL, 0, "MaxNPeriods", 40, 0, 2);
   upperBand201 = iCustom(NULL, 0, "MaxNPeriods", 20, 0, 1);


   lowerBand1 = iCustom(NULL, 0, "MinNPeriods", 20, 0, 1);
   lowerBand2 = iCustom(NULL, 0, "MinNPeriods", 40, 0, 2);

   //Apertura de Trade
   if(OrdersTotal() == 0)
   {
      if(Close[2] < upperBand2 && Close[1] > upperBand2)
      {
         OrdenAbierta = trader.Buy(0.01);
      }
      if(Close[2] > lowerBand2 && Close[1] < lowerBand2)
      {
         OrdenAbierta = trader.Sell(0.01);
      }
   }

   //Modificar STP
   if(OrdersTotal() == 1 && info.TypeOrder(OrdenAbierta) == "OP_BUY" && info.OrderSTP(OrdenAbierta)!=lowerBand1)
   {
      
      control = trader.STPPriceModifier(OrdenAbierta, lowerBand1);
   }
   if(OrdersTotal() == 1 && info.TypeOrder(OrdenAbierta) == "OP_SELL" && info.OrderSTP(OrdenAbierta)!=upperBand201)
   {
      control = trader.STPPriceModifier(OrdenAbierta, upperBand201);
   }

   Comment("Ordenes abiertas: " + OrdersTotal() +
           "\nOrden abierta: " + OrdenAbierta +
           "\nTipor de orden abierta: " + info.TypeOrder(OrdenAbierta) +
           "\nDatos de control " + control + " " + upperBand201);
}
//+------------------------------------------------------------------+
