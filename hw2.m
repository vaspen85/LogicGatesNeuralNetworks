w1=rand;
w2=rand;
w3=rand;
d=0.9;
x1=0.1;
x2=0.9;
x3=1;
a=x1.*w1+x2.*w2+x3.*w3;
y=(1+exp(-a)).^(-1);
e=(y-d).^2;
err=[];
w_1=[];
w_2=[];
w_3=[];
err = [err, e];
w_1=[w_1,w1];
w_2=[w_2,w2];
w_3=[w_3,w3];
while e>.001
  dw1=2.*(d-y).*y.*(1-y).*x1;
  dw2=2.*(d-y).*y.*(1-y).*x2;
  dw3=2.*(d-y).*y.*(1-y).*x3;
  w1=w1+dw1;
  w2=w2+dw2;
  w3=w3+dw3;
  a=x1.*w1+x2.*w2+x3.*w3;
  y=(1+exp(-a)).^(-1);
  e=(y-d).^2;
  err = [err, e];
  w_1=[w_1,w1];
  w_2=[w_2,w2];
  w_3=[w_3,w3];
end
figure
subplot(2,1,1)
plot(err)
xlabel ("# of Iterations")
ylabel ("Error")
title('Error plot')
subplot(2,1,2)
plot(w_1,"x-",w_2,"s-",w_3,"d-")
xlabel ("# of Iterations")
ylabel ("weights")
title('Weight plot')