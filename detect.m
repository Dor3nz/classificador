function [numhor,numver] = detect(imatge)
I = rgb2gray(imatge);
BW = edge(I,'sobel');
[H,T,R] = hough(BW);
%imshow(H,[],'XData',T,'YData',R,...
%            'InitialMagnification','fit');
%xlabel('\theta'), ylabel('\rho');
%axis on, axis normal, hold on;
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
%plot(x,y,'s','color','white');
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
%figure, hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');

%%Numero de lineas verticals i horitzontals
numver = 0;
numhor = 0;
sizehor = zeros(1,50);
sizever = zeros(1,50);
for q = 1:length(lines)
    if((lines(q).point1(2) == lines(q).point2(2)) && (lines(q).point2(1) - lines(q).point1(1)) > 20 )
        numhor = numhor + 1;
        sizehor(q) = lines(q).point2(1) - lines(q).point1(1);
    
    elseif((lines(q).point1(1) == lines(q).point2(1)) && (lines(q).point2(2) - lines(q).point1(2)) > 5)
        numver = numver + 1;
        sizever(q) = lines(q).point2(2) - lines(q).point1(2);
    end
end
