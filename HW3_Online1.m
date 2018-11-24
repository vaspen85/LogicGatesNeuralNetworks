W = [rand ;rand ;rand];
X = [.1 .1 1 ; .1 .9 1 ; .9 .1 1 ; .9 .9 1];
D = [.1 ; .1 ; .1 ; .9];
%D = [.1 ; .9 ; .9 ; .9];
E = [50 ; 50 ; 50 ; 50];
for i = 1:4
  a = X(i,1)*W(1) + X(i,2)*W(2) + X(i,3)*W(3);
  y = (1+exp(-a))^(-1);
  E(i) = (y - D(i))^2;
end
Wplot1 = [];
Wplot2 = [];
Wplot3 = [];
Eplot = [E(1)];
Wplot1 = [Wplot1,W(1)];
Wplot2 = [Wplot2,W(2)];
Wplot3 = [Wplot3,W(3)]; 
AvError = mean(E);
PlotAvError = [];
PlotAvError = [PlotAvError, AvError];
k=0;
while AvError>.01
  for i = 1:4
    while E(i)>.01
      dw1 = 2.*(D(i)-y).*y.*(1-y).*X(i,1);
      dw2 = 2.*(D(i)-y).*y.*(1-y).*X(i,2);
      dw3 = 2.*(D(i)-y).*y.*(1-y).*X(i,3);
      W(1) = W(1) + dw1;
      W(2) = W(2) + dw2;
      W(3) = W(3) + dw3;
      a = X(i,1)*W(1) + X(i,2)*W(2) + X(i,3)*W(3);
      y = (1+exp(-a))^(-1);
      E(i) = (y - D(i))^2;
      Wplot1 = [Wplot1,W(1)];
      Wplot2 = [Wplot2,W(2)];
      Wplot3 = [Wplot3,W(3)];
      AvError = mean(E);
      PlotAvError = [PlotAvError,AvError];
    end
  end
  k=k+1
  display('iterations')
  for i = 1:4
    a = X(i,1)*W(1) + X(i,2)*W(2) + X(i,3)*W(3);
    y = (1+exp(-a))^(-1);
    E(i) = (y - D(i))^2;
  end
  AvError = mean(E);
  PlotAvError = [PlotAvError,AvError];
  
end

  a = X(4,1)*W(1) + X(4,2)*W(2) + X(4,3)*W(3);
  y = (1+exp(-a))^(-1)
Wstr = {"w1", "w2", "w3"};
Estr = {"Error"};
figure
subplot(2,1,1)
hold on;
plot(Wplot1,"x-",Wplot2,"s-",Wplot3,"d-")
xlabel("# of iterations")
ylabel("Weights")
title('Weight plot')
legend(Wstr{:})
subplot(2,1,2)
hold on;
plot(PlotAvError)
xlabel("# of iterations")
ylabel("Averege Error")
title('Average Error plot')
legend(Estr{:})