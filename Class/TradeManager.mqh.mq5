//+------------------------------------------------------------------+
//|                                                 TradeManager.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
class TradeManager
{
   public:
   int Buy(double Lots, double Target, double Stop, int Magic = 0)
   {
      //Funcionando
      int O = OrderSend(NULL, OP_BUY, Lots, Ask, 3, Ask - (Stop * Point), Ask + (Target * Point), DoubleToString(Ask), Magic, 0, clrGreen);
      return O;
   }
   int Sell(double Lots, double Target, double Stop, int Magic = 0)   //Funcionando
   {
      int V = OrderSend(NULL, OP_SELL, Lots, Bid, 3, Bid + (Stop * Point), Bid - (Target * Point), DoubleToString(Bid), Magic, 0, clrRed);
      return V;
   }

};

//+------------------------------------------------------------------+
