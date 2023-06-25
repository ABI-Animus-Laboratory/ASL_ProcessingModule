clear;clc;
PWD=pwd;addpath(PWD)
path2bids='C:\Users\sdem348\Desktop\TestASLPipe';
path2xasl='C:\Users\sdem348\Desktop\ExploreASL-1.10.1';
subject="sub-002";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Do not need to change anything below %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(path2bids)
writedataPar(subject)
cd(path2xasl)
% Note, as  you run xASL, it will zip any unzipped nifti's you have open in
% the derivates folder. Not a bad thing but may add unexpected sim time.
%delete(strcat(path2bids,'\derivatives\ExploreASL\dataPar.json'))
x=ExploreASL(path2bids,0,[1 1 1]);
delete(strcat(path2bids,'\derivatives\ExploreASL\dataPar.json'))
cd(PWD)
%% Set up all paths
P=makepaths(path2bids,subject);
%% Do the PVC and save some derivatives
ASL4D = loadNift(P.pathASLNAT); %load raw ASL
PV(:,:,:,1)=loadNift(P.pathPVgmNAT); %load GM
PV(:,:,:,2)=loadNift(P.pathPVwmNAT); %load WM, both into matrix for PVC
[imPVC,imCBFrec,imResidual] = xASL_im_PVCkernel(ASL4D, PV, [5 5 1], 'flat'); %perform PVC
xASL_io_SaveNifti(P.pathASLNAT.nii,P.pathPVCNAT.nii, imCBFrec) %save raw PVC
xASL_io_SaveNifti(P.pathASLNAT.nii,P.pathPVCres.nii, imResidual) %save raw residuals
BrainMask=squeeze(PV(:,:,:,1)+PV(:,:,:,2));
BrainMask(BrainMask>0.5)=1; %create brain mask for tissues with >50% volume GM/WM
A=zeros(size(BrainMask));
A(BrainMask==1)=1; %Make raw mask
xASL_io_SaveNifti(P.pathASLNAT.nii,P.pathmaskNAT.nii, A) %Save raw mask
A(BrainMask==1)=imCBFrec(BrainMask==1); %Make  PVC mask
xASL_io_SaveNifti(P.pathASLNAT.nii,P.pathPVCmaskNAT.nii, A) %Save PVC mask
%% transform PVC and PVC masked to MNI
%We have to rename whatever we want to move from ASL into MNI because it's
%only designed to run on ASL4D within xASL. It's a lot more work to add
%functionality than just shuffle names.
renameNift(P.pathASLMNI,P.pathASLORIMNI)
renameNift(P.pathASLNAT,P.pathASLORINAT)
renameNift(P.pathPVCNAT,P.pathASLNAT)
xASL_wrp_ResampleASL(x); %transform ASLPVC into MNI and store in \population
renameNift(P.pathASLMNI,P.pathPVCMNI)
renameNift(P.pathASLNAT,P.pathPVCNAT)
%%
renameNift(P.pathASLORINAT,P.pathASLNAT)
renameNift(P.pathASLORIMNI,P.pathASLMNI)
%% Make MNI Brain Mask and use mask on raw PVC MNI
PV=[];
PV(:,:,:,1)=loadNift(P.pathPVgmMNI); %load GM
PV(:,:,:,2)=loadNift(P.pathPVwmMNI); %load WM, both into matrix for PVC
PVCMNI=loadNift(P.pathPVCMNI); %load WM, both into matrix for PVC
BrainMask=squeeze(PV(:,:,:,1)+PV(:,:,:,2));
BrainMask(BrainMask>0.5)=1; %create brain mask for tissues with >50% volume GM/WM
A=zeros(size(BrainMask));
A(BrainMask==1)=1; %Make raw mask
xASL_io_SaveNifti(P.pathPVCMNI.nii, P.pathmaskMNI.nii, A) %Save raw mask
A(BrainMask==1)=PVCMNI(BrainMask==1); %Make  PVC mask
xASL_io_SaveNifti(P.pathPVCMNI.nii, P.pathPVCmaskMNI.nii, A) %Save PVC mask
%% Compute BFF
%Note, saves PVC ASL data as the json, but fractions are near identical to original
path2atlas=char(strcat(PWD,'\ArterialAtlas_level2.nii'));
[BFF] = computeBFF(path2bids,subject,path2atlas) ;
cd(PWD)
%% Compute Total Flow
% This is optional if you want to see total brain flow in mL/s over the
% brain mask.
%Flow = compute_TotalFlow(path2bids,subject);