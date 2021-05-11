function outFRF = myFRF(Y1,Y2,typ,aves)
%MYFRF This is a function that computes FRF estimates based on an input and
%output linear spectrum. This function permits blocked data, which should
%have the data running top to bottom and blocks left to right. NOTE: Y1 is
%input data and Y2 is output data.



%% perform the power spectrum calculations
% H1(w) = Gfx(w)/Gff(w)
Gfx = conj(Y1).*Y2;
Gff = conj(Y1).*Y1;

% H2(w) = Gxx(w)/Gxf(w)
Gxx = conj(Y2).*Y2;
Gxf = conj(Y2).*Y1;

%% perform averages
GfxAVE = mean(Gfx(:,1:aves),2);
GffAVE = mean(Gff(:,1:aves),2);
GxxAVE = mean(Gxx(:,1:aves),2);
GxfAVE = mean(Gxf(:,1:aves),2);

%% compute FRFs
FRFs.H1  = GfxAVE./GffAVE;
FRFs.H2  = GxxAVE./GxfAVE;

%% compute coherence
% gamma^2_fx = [Gfx(w)*Gxf(w)]/[Gff(w)*Gxx(w)]
Coherence = (GfxAVE.*GxfAVE)./...
            (GffAVE.*GxxAVE);
        
%% return the FRF based on user choice
switch typ
    
    case {"H1","h1"}
        outFRF.H   = FRFs.H1;
        outFRF.Coh = Coherence;
        
    case {"H2","h2"}
        outFRF.H   = FRFs.H2;
        outFRF.Coh = Coherence;
        
    otherwise
        error("Please pick a proper FRF estimate approach")
        
end


end

