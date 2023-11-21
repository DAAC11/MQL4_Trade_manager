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
   int               Buy(double Lots, double Target, double Stop, int Magic = 0)
     {
      //Funcionando
      int O = OrderSend(NULL, OP_BUY, Lots, Ask, 3, Ask - (Stop * Point), Ask + (Target * Point), DoubleToString(Ask), Magic, 0, clrGreen);
      return O;
     }
   int               Sell(double Lots, double Target, double Stop, int Magic = 0)   //Funcionando
     {
      int V = OrderSend(NULL, OP_SELL, Lots, Bid, 3, Bid + (Stop * Point), Bid - (Target * Point), DoubleToString(Bid), Magic, 0, clrRed);
      return V;
     }
   int               Buy(double Lots)
     {
      int O = OrderSend(NULL, OP_BUY, Lots, Ask, 3, 0, 0, DoubleToString(Ask), 1, 0, clrGreen);
      return O;
     }
   int               Sell(double Lots)
     {
      int V = OrderSend(NULL, OP_SELL, Lots, Bid, 3, 0, 0, DoubleToString(Bid), 1, 0, clrRed);
      return V;
     }
   int               Buy(double Lots, double Stop)
     {
      int O = OrderSend(NULL, OP_BUY, Lots, Ask, 3, Ask - (Stop * Point), 0, DoubleToString(Ask), 1, 0, clrGreen);
      return O;
     }
   int               Sell(double Lots, double Stop)
     {
      int V = OrderSend(NULL, OP_SELL, Lots, Bid, 3, Bid + (Stop * Point), 0, DoubleToString(Bid), 1, 0, clrRed);
      return V;
     }
   int               BuyPriceTS(double Lots, double TargetPrice, double StopPrice, int Magic = 0)
     {
      //Funcionando
      int O = OrderSend(NULL, OP_BUY, Lots, Ask, 3, StopPrice, TargetPrice, DoubleToString(Ask), Magic, 0, clrGreen);
      return O;
     }
   int               SellPriceTS(double Lots, double TargetPrice, double StopPrice, int Magic = 0)   //Funcionando
     {
      int V = OrderSend(NULL, OP_SELL, Lots, Bid, 3, StopPrice, TargetPrice, DoubleToString(Bid), Magic, 0, clrRed);
      return V;
     }
   void              CloseOrder(int Ticket)
     {
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         if(OrderType() == OP_BUY)
           {
            OrderClose(Ticket, OrderLots(), Bid, 3, clrBlueViolet);
           }
         if(OrderType() == OP_SELL)
           {
            OrderClose(Ticket, OrderLots(), Ask, 3, clrBlueViolet);
           }
        }
     }


   void              STPModifier(int Ticket, double value)
     {
      double normaliceValue = NormalizeDouble(value, Digits);
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         OrderModify(Ticket, OrderOpenPrice(), normaliceValue, OrderTakeProfit(), 0, clrAqua);
        }
     }
   void              TGRModifier(int Ticket, double value)
     {
      double normaliceValue = NormalizeDouble(value, Digits);
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         OrderModify(Ticket, OrderOpenPrice(), OrderStopLoss(), normaliceValue, 0, clrAqua);
        }
     }

   int               BEPrice(int Ticket, double Price)
     {
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderStopLoss() < OrderOpenPrice())
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  Price,
                                  OrderTakeProfit(),
                                  0,
                                  clrAquamarine);
              }
           }
         else
           {
            Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));
           }
         if(OrderType() == OP_SELL)
           {
            if(OrderStopLoss() > OrderOpenPrice())
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  Price,
                                  OrderTakeProfit(),
                                  0,
                                  clrAquamarine);
              }
           }
         else
           {
            Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));
           }
        }
      return -1;
     }

   int               STPPriceModifier(int Ticket, double Price)
     {
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderStopLoss() != Price)
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  Price,
                                  OrderTakeProfit(),
                                  0,
                                  clrAquamarine);
              }
            else
              {
               Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));

              }
           }

         if(OrderType() == OP_SELL)
           {
            if(OrderStopLoss() != Price)
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  Price,
                                  OrderTakeProfit(),
                                  0,
                                  clrAquamarine);
              }
            else
              {
               Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));

              }
           }

        }
      return -1;
     }
   int               TGRPriceModifier(int Ticket, double Price)
     {
      if(OrderSelect(Ticket, SELECT_BY_TICKET))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderStopLoss() != Price)
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  OrderStopLoss(),
                                  Price,
                                  0,
                                  clrAquamarine);
              }
            else
              {
               Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));

              }
           }

         if(OrderType() == OP_SELL)
           {
            if(OrderStopLoss() != Price)
              {
               return OrderModify(OrderTicket(),
                                  OrderOpenPrice(),
                                  OrderStopLoss(),
                                  Price,
                                  0,
                                  clrAquamarine);
              }
            else
              {
               Print(IntegerToString(GetLastError()) + " " + IntegerToString(OrderTicket()));

              }
           }

        }
      return -1;
     }
  };

//+------------------------------------------------------------------+
