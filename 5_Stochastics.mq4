//+------------------------------------------------------------------+
//|                                                5_Stochastics.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "\\Class\\TradeManager.mqh"
#include "\\Class\\OrderInfo.mqh"
input int momentumPeriods = 20;
TradeManager trader;
OrderInfo info;
int openTrade;

double stockA, stockB;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
   if(OrdersTotal() == 0 && CumpleCondicionEstocasticoKDiario())
     {
      openTrade = trader.Buy(0.01);
     }
   else
      if(OrdersTotal() == 0 &&CumpleCondicionEstocasticoKDiariob())
        {
         openTrade = trader.Sell(0.01);
        }
   if(OrdersTotal() == 1 && CumpleCondicionEstocasticoKDiariob() && info.TypeOrder(openTrade) == "OP_SELL")
     {
      trader.CloseOrder(openTrade);
     }
   else
      if(OrdersTotal() == 1 &&CumpleCondicionEstocasticoKDiario() && info.TypeOrder(openTrade) == "OP_BUY")
        {
         trader.CloseOrder(openTrade);
        }

   Comment("\nfase1 "+fase1 +
"\nfase2 "+fase2 +
"\nfase3"+fase3+
"\nfase1b "+fase1b +
"\nfase2b"+fase2b +
"\nfase3b"+fase3b );
  }
//+------------------------------------------------------------------+
// Variables para el seguimiento de las fases
bool fase1 = false;
bool fase2 = false;
bool fase3 = false;
datetime lastBarTime = 0; // Hora de la vela anterior

//+------------------------------------------------------------------+
//| Función para verificar si se cumple la condición en una vela diaria |
//+------------------------------------------------------------------+
bool CumpleCondicionEstocasticoKDiario()
{
   double stochK;
   int counted_bars = IndicatorCounted();

   // Obtén el tiempo actual
   datetime currentBarTime = iTime(Symbol(), 0, 0);

   // Comprueba si ha comenzado una nueva vela diaria
   if (currentBarTime != lastBarTime)
   {
      fase1 = false; // Reinicia las variables de fase al inicio de una nueva vela
      fase2 = false;
      fase3 = false;
      lastBarTime = currentBarTime; // Actualiza el tiempo de la última vela
   }

   // Calcula el indicador estocástico
   if (iStochastic(NULL, 0, 14, 3, 3, MODE_SMA, 0, MODE_MAIN, 0) < 0)
   {
      Print("Error al calcular el indicador estocástico.");
      return (false);
   }

   // Obtén el valor actual del indicador estocástico %K
   stochK = iStochastic(NULL, 0, 14, 3, 3, MODE_SMA, 0, MODE_MAIN, 0);

   // Verifica si se cumple la condición de la fase 1
   if (!fase1 && stochK > 20 && counted_bars == 0)
   {
      fase1 = true;
   }

   // Verifica si se cumple la condición de la fase 2
   if (fase1 && !fase2 && stochK < 20)
   {
      fase2 = true;
   }

   // Verifica si se cumple la condición de la fase 3
   if (fase2 && !fase3 && stochK > 20)
   {
      fase3 = true;
   }

   // Si se cumplieron todas las fases, se cumple la condición
   if (fase1 && fase2 && fase3)
   {
      return (true);
   }

   return (false);
}

bool fase1b = false;
bool fase2b = false;
bool fase3b = false;
datetime lastBarTimeb = 0; // Hora de la vela anterior

//+------------------------------------------------------------------+
//| Función para verificar si se cumple la condición en una vela diaria |
//+------------------------------------------------------------------+
bool CumpleCondicionEstocasticoKDiariob()
{
   double stochK;
   int counted_bars = IndicatorCounted();

   // Obtén el tiempo actual
   datetime currentBarTime = iTime(Symbol(), 0, 0);

   // Comprueba si ha comenzado una nueva vela diaria
   if (currentBarTime != lastBarTimeb)
   {
      fase1b = false; // Reinicia las variables de fase al inicio de una nueva vela
      fase2b = false;
      fase3b = false;
      lastBarTimeb = currentBarTime; // Actualiza el tiempo de la última vela
   }

   // Calcula el indicador estocástico
   if (iStochastic(NULL, 0, 14, 3, 3, MODE_SMA, 0, MODE_MAIN, 0) < 0)
   {
      Print("Error al calcular el indicador estocástico.");
      return (false);
   }

   // Obtén el valor actual del indicador estocástico %K
   stochK = iStochastic(NULL, 0, 14, 3, 3, MODE_SMA, 0, MODE_MAIN, 0);

   // Verifica si se cumple la condición de la fase 1
   if (!fase1b && stochK< 80 && counted_bars == 0)
   {
      fase1b = true;
   }

   // Verifica si se cumple la condición de la fase 2
   if (fase1b && !fase2b && stochK >80)
   {
      fase2b = true;
   }

   // Verifica si se cumple la condición de la fase 3
   if (fase2b && !fase3b && stochK <80)
   {
      fase3b = true;
   }

   // Si se cumplieron todas las fases, se cumple la condición
   if (fase1b && fase2b && fase3b)
   {
      return (true);
   }

   return (false);
}