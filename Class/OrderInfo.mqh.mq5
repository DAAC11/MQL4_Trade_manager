//+------------------------------------------------------------------+
//|                                                    OrderInfo.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
class OrderInfo
  {


   double            OrderSTP(int Ticket)
     {

      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         return OrderStopLoss();
        }
      return -1;
     }
   string            TypeOrder(int Ticket)
     {

      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         string StrType = "";
         if(OrderType() == 0)
            StrType = "OP_BUY";
         if(OrderType() == 1)
            StrType = "OP_SELL";
         if(OrderType() == 2)
            StrType = "OP_BUYLIMIT";
         if(OrderType() == 3)
            StrType = "OP_SELLLIMIT";
         if(OrderType() == 4)
            StrType = "OP_BUYSTOP";
         if(OrderType() == 5)
            StrType = "OP_SELLSTOP";
         return StrType;;
        }
      return -1;
     }
  };

//+------------------------------------------------------------------+
