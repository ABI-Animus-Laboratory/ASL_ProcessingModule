function Flow = computeTotalFlow(path2bids,subject)
%% total flow measured by ASL in mL/sec to compare with 4D-flow.
%as such, all computation is in native space (NAT)
P=makepaths(path2bids,subject);
Density=1081;% Density of white and gray matter (kg/m3)
ASL4Dpvc = loadNift(P.pathPVCNAT); %load PVC'd ASL
ASL4Dori = loadNift(P.pathASLORINAT); %load original ASL
PV(:,:,:,1)=loadNift(P.pathPVgmNAT); %load GM probability
PV(:,:,:,2)=loadNift(P.pathPVwmNAT); %load WM probability
PV=squeeze(PV(:,:,:,1)+PV(:,:,:,2));
PV(isnan(PV))=0;
Mask=loadNift(P.pathmaskNAT); %load Brain mask 
info = niftiinfo(P.pathPVCNAT.nii);
vol=info.PixelDimensions(1)*info.PixelDimensions(2)*info.PixelDimensions(3)./(10^9);%get volume in m3
[a,b,c]=size(ASL4Dpvc);
flowpersecori = 0;
flowpersecpvc = 0;
%count=0;
for i=1:a
    for j=1:b
        for k=1:c
            if Mask(i,j,k)==1
                PartialVol=PV(i,j,k)*vol;%vol in m3
                masskg=PartialVol*Density; %now in kg
                massg=masskg*1000;
                mass100g=massg/100;
                flowmLperminper100gpvc=ASL4Dpvc(i,j,k);
                flowmLperminper100gori=ASL4Dori(i,j,k);
                if flowmLperminper100gpvc<0
                    %count=count+1;
                    %val(count)=flowmLperminper100gpvc;
                else
                    flowmLperminpvc=flowmLperminper100gpvc*mass100g;
                    flowpersecpvc=flowpersecpvc+flowmLperminpvc/60;
                end
                if flowmLperminper100gori<0
                    %count=count+1;
                    %val(count)=flowmLperminper100gori;
                else
                    flowmLperminori=flowmLperminper100gori*mass100g;
                    flowpersecori=flowpersecori+flowmLperminori/60;
                end
            end
        end
    end
end
Flow(1)=flowpersecori;
Flow(2)=flowpersecpvc;
