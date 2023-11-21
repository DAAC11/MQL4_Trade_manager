//+------------------------------------------------------------------+
//|                                                    OrderInfo.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OrderInfo
  {

public:
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

   double            _openPrice(int ticket)
     {
      if(OrderSelect(ticket, SELECT_BY_TICKET))
        {
         return OrderOpenPrice();
        }
      else
        {
         return -1;
        }
     }
   double            profitOrder(int ticket)
     {
      if(OrderSelect(ticket, SELECT_BY_TICKET))
        {
         return OrderProfit();
        }
      else
        {
         return -1;
        }
     }

   bool              IsClose(int Ticket)
     {
      bool Control = false;
      for(int i = OrdersHistoryTotal() - 1; i > 0; i--)
        {
         if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
           {
            if(OrderTicket() == Ticket)
              {
               return Control = true;
              }
           }
        }
      return Control;
     }

   double            InfoByTicket(int Ticket, string Option)
     {
      double Salida = 0;
      if(Option == "OrderProfit")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderProfit();
           }
        }
      if(Option == "OrderLots")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderLots();
           }
        }
      if(Option == "OrderOpenPrice")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderOpenPrice();
           }
        }
      if(Option == "OrderClosePrice")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderClosePrice();
           }
        }
      if(Option == "OrderTakeProfit")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderTakeProfit();
           }
        }
      if(Option == "OrderStopLoss")
        {
         if(OrderSelect(Ticket, SELECT_BY_TICKET))
           {
            return Salida = OrderStopLoss();
           }
        }
      return -1;
     }
   int               LastTicketClose() //Funcionando
     {
      int last = 0;
      if(OrderSelect(OrdersHistoryTotal() - 1, SELECT_BY_POS, MODE_HISTORY))
        {
         last = OrderTicket();
        }
      return last;
     }
  };

//+------------------------------------------------------------------+
