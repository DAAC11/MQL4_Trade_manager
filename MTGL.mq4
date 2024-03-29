#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"
input double lotes = 0.01;
input int target = 100;
input int stop = 200;
TradeManager trader;
OrderInfo info;
int OrdenAbierta;
int OrdenAnteriorTicket;
string OrdenAnteriorType;
double OrdenAnteriorProfit;
int multiplicadorLotes = 1;
string Type = "";
bool control = true;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
//Apertura Inicial
   if(OrdersTotal() == 0 && control && OrdenAnteriorTicket == 0)
     {
      OrdenAbierta = trader.Buy(lotes * multiplicadorLotes, target, stop);
      
      control = false;
     }
//Apertura segun anterior
   if(OrdersTotal() == 0 && control)
     {
      if(OrdenAnteriorType == "OP_BUY" && OrdenAnteriorProfit > 0)
        {
         OrdenAbierta = trader.Buy(lotes * multiplicadorLotes, target, stop);
         multiplicadorLotes = 1;
         control = false;
        }
      if(OrdenAnteriorType == "OP_BUY" && OrdenAnteriorProfit < 0)
        {
         OrdenAbierta = trader.Sell(lotes * multiplicadorLotes, target, stop);
         multiplicadorLotes++;
         control = false;
        }
      if(OrdenAnteriorType == "OP_SELL" && OrdenAnteriorProfit > 0)
        {
         OrdenAbierta = trader.Sell(lotes * multiplicadorLotes, target, stop);
         multiplicadorLotes = 1;
         control = false;
        }
      if(OrdenAnteriorType == "OP_SELL" && OrdenAnteriorProfit < 0)
        {
         OrdenAbierta = trader.Buy(lotes * multiplicadorLotes, target, stop);
         multiplicadorLotes++;
         control = false;
        }
     }
//Last Order
   if(!control)
     {
      OrdenAnteriorTicket = info.LastTicketClose();
      OrdenAnteriorType = info.TypeOrder(OrdenAnteriorTicket);
      OrdenAnteriorProfit = info.InfoByTicket(OrdenAnteriorTicket, "OrderProfit");
      control = true;

     }


   Comment("\nOrdersTotal: ", OrdersTotal(),
           "\nControl: ", control,
           "\nOrdernAbierta: ", OrdenAbierta,
           "\nOrdenAnteriorTicket: ", OrdenAnteriorTicket,
           "\nOrdenAnteriorType: ", OrdenAnteriorType,
           "\nOrdenAnteriorProfit: ", OrdenAnteriorProfit,
           "\nmultiplicadorLotes: ", multiplicadorLotes);
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
