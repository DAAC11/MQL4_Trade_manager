  //+------------------------------------------------------------------+
//|                                             3_Momentum_80_20.mq4 |
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

double MomentumActual;
double MaxMomentum;
double MinMomentum;
int openTrade;
void OnTick()
  {
//---


   MaxMomentum =  MomentumMax(momentumPeriods, momentumPeriods);
   MinMomentum =  MomentumMin(momentumPeriods, momentumPeriods);
   MomentumActual = iMomentum(NULL, 0, momentumPeriods, PRICE_CLOSE, 1);

   if(OrdersTotal() == 0 && MomentumActual == MaxMomentum)
     {
      openTrade = trader.Buy(0.01);
     }
   if(OrdersTotal() == 0 && MomentumActual == MinMomentum)
     {
      openTrade = trader.Sell(0.01);
     }

   if(OrdersTotal() == 1)
     {
      if(info.TypeOrder(openTrade) == "OP_BUY" && MomentumActual == MinMomentum)
        {
         trader.CloseOrder(openTrade);
        }
      if(info.TypeOrder(openTrade) == "OP_SELL" && MomentumActual == MaxMomentum)
        {
         trader.CloseOrder(openTrade);
        }
     }

   Comment("momentum atual :" + MomentumActual +
           "\nmomentum max: " + MaxMomentum +
           "\nSeñan: " + (MomentumActual > MaxMomentum));
  }
//+------------------------------------------------------------------+
double MomentumMax(int periodsM, int maxNPeriods)
  {
   double Max;
   double Comparador;
   for(int i = 1; i <= maxNPeriods; i++)
     {
      if(i == 1)
        {
         Max = iMomentum(NULL, 0, periodsM, PRICE_CLOSE, 1);
        }
      if(Max < iMomentum(NULL, 0, periodsM, PRICE_CLOSE, i))
        {
         Max = iMomentum(NULL, 0, periodsM, PRICE_CLOSE, i);
        }
     }
   return Max;
  }
//+------------------------------------------------------------------+
double MomentumMin(int periodsM, int minNPeriods)
  {
   double Min;
   double Comparador;
   for(int i = 1; i <= minNPeriods; i++)
     {
      if(i == 1)
        {
         Min = iMomentum(NULL, 0, periodsM, PRICE_CLOSE, 1);
        }
      if(Min > iMomentum(NULL, 0, periodsM, PRICE_CLOSE, i))
        {
         Min = iMomentum(NULL, 0, periodsM, PRICE_CLOSE, i);
        }
     }
   return Min;
  }
//+------------------------------------------------------------------+
/*
   +Con 20 de momentum y salida con la señal contraria da un 50% de acierto 1990 a 2001
   +Con 80 de momentum y salida con la señal contraria da un 44% de acierto 1990 a 2001
   
*/