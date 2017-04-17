function dydt = f(t,y)
    dydt = [y(2);-g/L*sin(y(1))]
endfunction

function y=euler(theta0,t)
    n=length(t);
    h=t(2)-t(1);
    y(1,1)=theta0;
    y(2,1)=0;
    for i=1:n-1
        y(1,i+1)=y(1,i)+h*y(2,i);
        y(2,i+1)=y(2,i)+h*(-g/L*sin(y(1,i)));
    end
endfunction

function y = solution_approx(theta0,t)
    y = theta0*cos(sqrt(g/L)*t);
endfunction

g=9,81;
L=1;
t=linspace(0,10,10000);
gammeTheta = [%pi/32,%pi/16,%pi/8,%pi/2,3*%pi/4,63*%pi/64];
nomTheta = ["\\frac{\\pi}{32}","\\frac{\\pi}{16}","\\frac{\\pi}{8}",
"\\frac{\\pi}{2}","\\frac{3\\pi}{4}","\\frac{63\\pi}{64}"];

clf;
for i=1:length(gammeTheta)
    theta0=gammeTheta(i);
    y=euler(theta0,t);
    //on aurait pu resoudre avec ode : y2=ode([theta0;0],0,t,1e-10,f);
    subplot(3,2,i);
    plot(t,y(1,:),'r');
    //on obtient le meme affichage avec plot(t,y2(1,:),'g');
    plot(t,solution_approx(theta0,t),'b');
    title(sprintf('$$\\theta_0='+nomTheta(i)+'$$'));
end
