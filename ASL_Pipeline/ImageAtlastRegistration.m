path2bids='Z:\Sergio\ExampleBIDS_Study'; %ROOT
subject='sub-001';
PWD=pwd;
path2atlas=char(strcat(PWD,'\ArterialAtlas_level2.nii'));
%% compute blood flow fractions in MNI space. 
P = makepaths(path2bids,subject);
VascAtlas = xASL_io_Nifti2Im(path2atlas); %load vascular atlas MNI
PWI=loadNift(P.pathASLMNI); %load original perfusion MNI
PWIPVC=loadNift(P.pathPVCMNI); %load PVC ASL 
mask=loadNift(P.pathmaskMNI); %load brain mask
VascAtlsrshp = round(imresize3(VascAtlas,size(PWI),'Method','nearest')); %Resize atlas to xASL resolution
PWI(isnan(PWI))=0;
PWIPVC(isnan(PWIPVC))=0;
%% Test again
VascAtlsrshp(VascAtlsrshp>0)=1;
Overlap=VascAtlsrshp+mask;
figure(1)
montage([VascAtlsrshp(:,:,1:10:end);mask(:,:,1:10:end)])
Overlap(Overlap<2)=0;
figure(2)
volshow(Overlap)