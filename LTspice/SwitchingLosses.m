clc
clear all

Run=1;

Ta=25;
Tb=125;

if(1)%Internaltional system prefixs

  m=1*10^-3;
  u=1*10^-6;
  n=1*10^-9;
  p=1*10^-12;
  f=1*10^-12;
  k=1*10^3;

end

if(1)%Mosfet Parameters EPC2204
  Vth=1.1;
  %dVth=*m;
  %kVth=dVth/Vt;
  Rds=4*m;
  Rdshot=Rds*1.72;
  %Vth=Vt*(1+kVth*(Tb-Ta));
  %Rds=*m;
  Coss=456*p;
  Ciss=851*p;
  Qg=7.4*n;
  Qgd=0.8*n;
  Qgs=1.8*n;
  %Qgs1=*n;
  %Qgs2=Qgs-Qgs1;
  Qsw=1/2*Qgs+Qgd;
  Vpl=2;
  RgEPC=0.5;
  %gfs=;
end
if(1)%Gate and driver parameters
  Vdrv=5;
  Rgint=0;
  Rgext=1;
  Rgon=Rgint+Rgext+RgEPC;
  Rgoffint=0;
  Rgoffext=1;
  Rgoff=Rgoffint+Rgoffext+RgEPC;
end
if(1)%Converter parameters
  Vin=20;
  Vout=40;
  td=20*n;%dead time
  eff=0.95;
  Iout=10;
  Iin=Iout*Vout/Vin/eff;
  L=2.2*u;
  Fsw=500*k;
  Vfdw=2;
  D=(Vout-Vin)/Vout;
  Dil=Vin/L*D/Fsw;
  Ilmax=Iin+Dil/2;
  Ilmin=Iin-Dil/2;
  IswRms=(D/3*(Ilmin^2+Ilmin*Ilmax+Ilmax^2))^0.5;
  IswRmsH=((1-D)/3*(Ilmin^2+Ilmin*Ilmax+Ilmax^2))^0.5;
  Vbus=Vout+Vfdw;
end
if(1) %Swithing and cond. Losses

  %Conduction Losses
  PcLs=Rdshot*IswRms^2;
  PcHs=Rdshot*IswRmsH^2;

  %Reverse recovery losses
  PrrLs=0;
  PrrHs=0;

  %Coss Losses
  PcossHs=0;
  PcossLs=1/2*Fsw*Coss*Vbus^2;

  %Gate Losses
  PgHs=Fsw*Qg*Vdrv;
  PgLs=Fsw*Qg*Vdrv;

  %Reverse Conduction Losses
  PdtLs=0;
  PdtHs_Off=td*Fsw*Ilmin*Vfdw;
  PdtHs_On=td*Fsw*Ilmin*Vfdw;
  PdtHs=PdtHs_Off+PdtHs_On;

  %SWITCHING LOSSES ON LOW SIDE
  PswHs=0; %(Let's discuss this)
  Ton=Qsw/((Vdrv-Vpl)/Rgon);
  Toff=Qsw/(Vpl/Rgoff);
  PswLs=1/2*Fsw*Vbus*(Ilmin*Ton+Ilmax*Toff);

  HsLoss=PcHs+PgHs+PswHs+PdtHs;
  LsLoss=PcLs+PgLs+PswLs+PdtLs+PcossLs;

end

if(1)%Print
    printf("EPC2204 Losses Script \n");
    printf("Vin    :%d [V] \n",Vin);
    printf("Vout   :%d [V] \n",Vout);
    printf("D      :%f \n",D);
    printf("Fsw:   :%d [kHz] \n",Fsw/k);
    printf("IswMax :%f [A] \n",Ilmax);
    printf("IswMin :%f [A] \n",Ilmin);
    printf("IswRms :%f [A] \n",IswRms);
  printf("-------------------------------- \n");
    printf("Temp   :%d [C] \n",Tb);
    printf("Vth    :%d [V] \n",Vth);
    printf("Rdshot :%f [mOHm] \n",Rdshot/m);
  printf("--------------------------------- \n");
    printf("High Side Losses \n");
    printf("Conduction Losses: %f [W]\n",PcHs);
    printf("Reverse Recovery Losses: %f [W] \n",PrrHs);
    printf("Reverse Conduction Losses: %f [W] \n",PdtHs);
    printf("Gate Losses: %f [W] \n",PgHs);
    printf("Switching Losses: %f [W] \n",PswHs);
    printf("Coss Losses: %f [W] \n",PcossHs)
    printf("Total Losses: %f [W] \n",HsLoss);
    printf("LTspice Simulation HS: 2.39 [W] \n");
  printf("---------------------------------- \n");
    printf("Low Side Losses \n");
    printf("Conduction Losses: %f [W]\n",PcLs);
    printf("Reverse Recovery Losses: %f [W] \n",PrrLs);
    printf("Reverse Conduction Losses: %f [W] \n",PdtLs);
    printf("Gate Losses: %f [W] \n",PgLs);
    printf("Coss Losses: %f [W] \n",PcossLs)
    printf("Switching Losses: %f [W] \n",PswLs)
    printf("Total Losses: %f [W] \n",LsLoss);
  printf("----------------------------------------\n");
 end
