loadConstants;

radius = 24.0;

pqrData = readpqr('bpti.pqr');
pqrData.xyz = pqrData.xyz - ones(length(pqrData.q),1)*mean(pqrData.xyz);

epsIn      = 2;  
epsInLocal2 = 2;
epsInLocal4 = 4;
epsOut     = 80;
epsInfty   = 1.8;
lambdaVec  = [1 10];
localLambdaVec = 1e-10;

Nmax = 30;
[gridPqrData,Ygrid,Zgrid]=  addPqrGrid(radius, struct('q',[],'xyz',[]), 0.2);

maxPot = -1e10;
minPot = 1e10;

[results_local2, minPot, maxPot] = solveEverywhereLocal(radius, ...
						  epsInLocal2, epsOut, ...
						  pqrData, gridPqrData, ...
						  Nmax, minPot, ...
						  maxPot,Ygrid);
[results_local4, minPot, maxPot] = solveEverywhereLocal(radius, ...
						  epsInLocal4, epsOut, ...
						  pqrData, gridPqrData, ...
						  Nmax, minPot, ...
						  maxPot,Ygrid);

for i=1:length(lambdaVec)
  [results_nl(i), minPot, maxPot] = solveEverywhereNonlocal(radius, ...
						  epsIn, epsOut, ...
						  epsInfty, lambdaVec(i),...
						  pqrData, ...
						  gridPqrData, Nmax, ...
						  minPot, maxPot, ...
						  Ygrid);
  
end

contourColors = minPot:(maxPot-minPot)/20:maxPot;

leftstart = 0.06;
topstart = 0.54;
rightstart = 0.55;
botstart = 0.09;
imwidth = 0.30;
imheight = 0.45;

figure;
subplot(2,2,1);
contourf(Ygrid,Zgrid,results_local2.gridPotentials,contourColors, ...
         'linestyle', 'none');
axis equal; caxis([minPot maxPot]); colorbar;
set(gca,'fontsize',16,'position',[leftstart topstart imwidth imheight]);
title('(a)');

subplot(2,2,2);
contourf(Ygrid,Zgrid,results_local4.gridPotentials,contourColors, ...
         'linestyle', 'none');
axis equal; caxis([minPot maxPot]); colorbar;
set(gca,'fontsize',16,'position',[rightstart topstart imwidth imheight]);
title('(b)');

subplot(2,2,3);
contourf(Ygrid,Zgrid,results_nl(1).gridPotentials,contourColors, ...
         'linestyle', 'none');
axis equal; caxis([minPot maxPot]); colorbar;
set(gca,'fontsize',16,'position',[leftstart botstart imwidth imheight]);
title('(c)');

subplot(2,2,4);
contourf(Ygrid,Zgrid,results_nl(2).gridPotentials,contourColors, ...
         'linestyle', 'none');
axis equal; caxis([minPot maxPot]); colorbar;
set(gca,'fontsize',16,'position',[rightstart botstart imwidth imheight]);
title('(d)');

print -depsc2 bpti-sphere-model.eps
print -dpng   bpti-sphere-model.png
