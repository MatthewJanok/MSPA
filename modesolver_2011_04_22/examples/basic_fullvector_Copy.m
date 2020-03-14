% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
rw = linspace(0.325,1.0,10);
side = 1.5;         % Space on side

% Grid size:
% dx = 0.0125*8;        % grid size (horizontal)
% dy = 0.0125*8;        % grid size (vertical)
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

for i = 1:10
 rwt = rw(i);
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rwt,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
% Hxt = Hx(:,:,i);
% Hyt = Hy(:,:,i);

fprintf(1,'neff = %.6f\n',neff);

figure(1);
subplot(121);
[X,Y] = meshgrid(x,y);
% contourmode(x,y,Hxt);
surf(X,Y,Hx')
shading interp
title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

subplot(122);
% contourmode(x,y,Hyt);
surf(X,Y,Hy')
shading interp
title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

figure(10)
hold on
plot(rwt,neff,'r.')
title('Neff')
hold off
end
% % Next consider the fundamental TM mode
% % (same calculation, but with opposite symmetry)
% 
% 
% [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');
% Hxt = Hx(:,:,i);
% Hyt = Hy(:,:,i);
% 
% fprintf(1,'neff = %.6f\n',neff);
% 
% figure(2);
% subplot(121);
% % contourmode(x,y,Hxt);
% surf(X,Y,Hxt');
% shading interp
% title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end
% 
% subplot(122);
% % contourmode(x,y,Hyt);
% surf(X,Y,Hyt');
% shading interp
% title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end
% 
% pause(0.1)
% end
