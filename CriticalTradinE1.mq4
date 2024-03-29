//+------------------------------------------------------------------+
#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"

TradeManager trader;
OrderInfo info;

input double lotes = 0.01;
input int target = 100;
input int stop = 200;
double upperBand;
double lowerBand;
double MA200;
int orden;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   upperBand = iCustom(NULL, 0, "MaxNPeriods", 7, 0, 1);
   lowerBand = iCustom(NULL, 0, "MinNPeriods", 7, 0, 1);
   MA200 = iMA(NULL,0,200,0,MODE_SMA,PRICE_CLOSE,1);
   
   //Entrada
   if(OrdersTotal() == 0)
     {
      if(Close[0]< lowerBand && Close[0] > MA200)
        {
         orden = trader.Buy(lotes);
        }
     }
   //Salida
   if(OrdersTotal() == 1)
     {
      if(Close[0] > upperBand || Close[0] < MA200)
        {
         trader.CloseOrder(orden);
        }
     }

  }
//+------------------------------------------------------------------+
/* Reglas
  + abre si:
    - el mercado cierra por debajo del minimo de los ultimos 7 dias
    - y el precio esta arriba de la media de 200
  + cierra si:
    - el mercado cierra ariba el maximo de 7 día
*/
//+------------------------------------------------------------------+
