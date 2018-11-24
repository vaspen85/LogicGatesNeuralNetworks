W = [rand ;rand ;rand];
X = [.1 .1 1 ; .1 .9 1 ; .9 .1 1 ; .9 .9 1];
%D = [.1 ; .1 ; .1 ; .9];
D = [.1 ; .9 ; .9 ; .9];
E = [50 ; 50 ; 50 ; 50];

for i = 1:4
  a = X(i,1)*W(1) + X(i,2)*W(2) + X(i,3)*W(3);
  y = (1+exp(-a))^(-1);
  E(i) = (y - D(i))^2;
end

Sumerror = sum(E)

Wplot1 = [];
Wplot2 = [];
Wplot3 = [];
Eplot = [];
Eplot = [Eplot, Sumerror];
Wplot1 = [Wplot1,W(1)];
Wplot2 = [Wplot2,W(2)];
Wplot3 = [Wplot3,W(3)]; 
dw1 = [0;0;0;0]
dw2 = [0;0;0;0]
dw3 = [0;0;0;0]

while Sumerror>.01
  W(1) = W(1) + sum(dw1);
  W(2) = W(2) + sum(dw2);
  W(3) = W(3) + sum(dw3);
  for i = 1:4
    a = X(i,1)*W(1) + X(i,2)*W(2) + X(i,3)*W(3);
    y = (1+exp(-a))^(-1);
    E(i) = (y - D(i))^2;
    dw1(i) = 2.*(D(i)-y).*y.*(1-y).*X(i,1);
    dw2(i) = 2.*(D(i)-y).*y.*(1-y).*X(i,2);
    dw3(i) = 2.*(D(i)-y).*y.*(1-y).*X(i,3);
  end
  Sumerror = sum(E);
  Eplot = [ Eplot, Sumerror];
  Wplot1 = [Wplot1,W(1)];
  Wplot2 = [Wplot2,W(2)];
  Wplot3 = [Wplot3,W(3)]; 
end
Wstr = {"w1", "w2", "w3"};
Estr = {"Error"};
figure
subplot(2,1,1)
hold on;
plot(Wplot1,"*-",Wplot2,".-",Wplot3,"d-")
xlabel("# of iterations")
ylabel("Weights")
title('Weight plot')
legend(Wstr{:})
subplot(2,1,2)
hold on;
plot(Eplot)
xlabel("# of iterations")
ylabel("Error")
title('Error plot')
legend(Estr{:})