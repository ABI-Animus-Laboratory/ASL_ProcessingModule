path2bids='C:\Users\sdem348\Desktop\TestASLPipe';
subject="sub-001";
P=makepaths(path2bids,subject);
PWI = loadNift(P.pathASLNAT); %load raw ASL
PVCPWI = loadNift(P.pathPVCmaskNAT); %load raw ASL
PVCPWIres = loadNift(P.pathPVCres); %load raw ASL
PVCPWI=imrotate(PVCPWI,90);

mask = loadNift(P.pathmaskNAT); %load raw ASL
ASLMask=zeros(size(PWI));
ASLMask(mask==1)=PWI(mask==1);
ASLMask=imrotate(ASLMask,90);

PVCresMask=zeros(size(PWI));
PVCresMask(mask==1)=PVCPWIres(mask==1);
PVCresMask=imrotate(PVCresMask,90);

slices=5;
raw=ASLMask(:,:,5:slices:end-5);
raw(raw<1)=1;
raw(raw>100)=100;
pvc=PVCPWI(:,:,5:slices:end-5);
pvc(pvc<1)=1;
pvc(pvc>100)=100;

pvcres=PVCresMask(:,:,5:slices:end-5);
pvcres(pvcres<1)=1;
pvcres(pvcres>100)=100;
pvcres=(pvcres-1)./pvc*100;

len=length(raw(1,1,:));
figure(1)
montage([raw; pvc],'Size',[1,len],"DisplayRange",[0 100]);
colorbar
map=[jet(50)];
map(1,:)=[0.15 0.15 0.15];
colormap(map)
title('Raw vs partial volume corrected')

figure(2)
montage([pvcres],'Size',[1,len],"DisplayRange",[0 50]);
c=colorbar;
map=[jet(50)];
map(1,:)=[0.15 0.15 0.15];
colormap(map)
c.Title.String='% diff';
title('residuals from correction')

