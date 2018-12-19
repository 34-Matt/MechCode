function [Z,x,y] = Tupper(n)
%Plots the tupper values for a given value n.  Otherwise, it plot tupper's
%self describing equation
    if ~exist('n','var')
        n = sym(['960939379918958884971672962127852754715004339660129306651505519271702802395266424689642842174350718121267153782770623355993237280874144307891325963941337723487857735749823926629715517173716995165232890538221612403238855866184013235585136048828693337902491454229288667081096184496091705183454067827731551705405381627380967602565625016981482083418783163849115590225610003652351370343874461848378737238198224849863465033159410054974700593138339226497249461751545728366702369745461014655997933798537483143786841806593422227898388722980000748404719']);
    end
    
    x = 106:-1:0;
    y = 0:16;
    [X,Y] = meshgrid(x,y);
    
    Z = 1/2 < floor(mod(floor((Y+n)/17).*2.^(-17.*floor(X)-mod(floor(Y+n), 17)),2));
    
    image((1-double(Z))*255);
    colormap gray
    axis equal
end