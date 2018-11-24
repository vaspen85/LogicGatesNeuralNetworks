Wx = [rand rand;rand rand;rand rand];
Wz = [rand ;rand;rand];
X = [.1 .1 1 ; .1 .9 1 ; .9 .1 1 ; .9 .9 1];
D = [.1 ; .9 ; .9 ; .1];
E = [50 ;50 ;50 ;50];
Averror = mean(E);
Wxplot1 = [];
Wxplot2 = [];
Wxplot3 = [];
Wxplot4 = [];
Wxplot5 = [];
Wxplot6 = [];
Wxplot1 = [Wxplot1,Wx(1,1)];
Wxplot2 = [Wxplot2,Wx(1,2)];
Wxplot3 = [Wxplot3,Wx(2,1)];
Wxplot4 = [Wxplot4,Wx(2,2)];
Wxplot5 = [Wxplot5,Wx(3,1)];
Wxplot6 = [Wxplot6,Wx(3,2)];
Wzplot1 = [];
Wzplot2 = [];
Wzplot3 = [];
Wzplot1 = [Wzplot1,Wz(1)];
Wzplot2 = [Wzplot2,Wz(2)];
Wzplot3 = [Wzplot3,Wz(3)];
Eplot = [];

while Averror>.01
  for n=1:4
    while E(n)>.01
      Ax = X*Wx;
      Z(:,1) = (1+exp(-Ax(:,1))).^(-1);  
      Z(:,2) = (1+exp(-Ax(:,2))).^(-1);
      Z(:,3) = [1;1;1;1];
      Az = Z*Wz;
      Y(:,1) = (1+exp(-Az(:,1))).^(-1); 
      E = (Y-D).^2;
   #2nd layer
      for j=1:3
        dWz(n,j) = -2.*(Y(n)-D(n)).*Y(n).*(1-Y(n)).*Z(n,j);
        Wz(j) = Wz(j) + dWz(n,j);
      end
   #1st layer
      k=1;
      for j=1:3
        for i=1:2
          dWx(n,k) = -2.*X(n,j).*Z(n,i).*(1-Z(n,i)).*(Y(n)-D(n)).*Y(n).*(1-Y(n)).*Wz(i);
          k=k+1;
        end
      end
      
      k = 1;
      for i = 1:3
        for j = 1:2
          Wx(i,j) = Wx(i,j) + dWx(n,k);
          k = k + 1;
        end
      end
             
      Wxplot1 = [Wxplot1, Wx(1,1)];
      Wxplot2 = [Wxplot2, Wx(1,2)];
      Wxplot3 = [Wxplot3, Wx(2,1)];
      Wxplot4 = [Wxplot4, Wx(2,2)];
      Wxplot5 = [Wxplot5, Wx(3,1)];
      Wxplot6 = [Wxplot6, Wx(3,2)];
      Wzplot1 = [Wzplot1, Wz(1)];
      Wzplot2 = [Wzplot2, Wz(2)];
      Wzplot3 = [Wzplot3, Wz(3)];
          
    end 
    Ax = X*Wx;
    Z(:,1) = (1+exp(-Ax(:,1))).^(-1);  
    Z(:,2) = (1+exp(-Ax(:,2))).^(-1);
    Z(:,3) = [1;1;1;1];
    Az = Z*Wz;
    Y(:,1) = (1+exp(-Az(:,1))).^(-1);
    E = (Y-D).^2;
    Averror = mean(E)
    Eplot = [ Eplot, Averror];
  end
end 
Y(:,1) = (1+exp(-Az(:,1))).^(-1) 
Wstr = {'w1', 'w2', 'w3', 'w4', 'w5', 'w6'};
Wstr2 = {'w1', 'w2', 'w3'};
Estr = {'Error'};
figure
subplot(3,1,1)
hold on;
plot(Wxplot1,'x-',Wxplot2,'s-',Wxplot3,'d-',Wxplot4,'o-',Wxplot5,'*-',Wxplot6)
xlabel('# of iterations')
ylabel('Layer 1 Weights')
title('Layer 1 Weight plot')
legend(Wstr{:})
subplot(3,1,2)
hold on;
plot(Wzplot1,"x-",Wzplot2,"s-",Wzplot3,"d-")
xlabel("# of iterations")
ylabel("Layer 2 Weights")
title('Layer 2 Weight plot')
legend(Wstr2{:})
subplot(3,1,3)
plot(Eplot)
xlabel("# of iterations")
ylabel("AvError")
title('AvError plot')
legend(Estr{:})