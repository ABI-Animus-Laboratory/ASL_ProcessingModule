function P = makepaths(path2bids,subject)
% Paths to main folders we'll be working in
path2ASL=strcat(path2bids,'\derivatives\ExploreASL\',subject,'_1\ASL_1\');
path2Pop=strcat(path2bids,'\derivatives\ExploreASL\Population\');


% paths to raw ASL files (inc GM and WM) in native space
P.pathASLNAT.nii=char(strcat(path2ASL,'ASL4D.nii'));
P.pathPVgmNAT.nii=char(strcat(path2ASL,'PVgm.nii'));
P.pathPVwmNAT.nii=char(strcat(path2ASL,'PVwm.nii'));
% paths to newly generated PVC files and masks in native space
P.pathASLORINAT.nii=char(strcat(path2ASL,'ASL4D_ORI.nii'));
P.pathPVCNAT.nii=char(strcat(path2ASL,'ASL_PVC.nii'));
P.pathPVCmaskNAT.nii=char(strcat(path2ASL,'ASL_PVCMask.nii'));
P.pathmaskNAT.nii=char(strcat(path2ASL,'BrainMask.nii'));
% paths to raw ASL files (inc PV GM and PV WM) in MNI space
P.pathASLMNI.nii=strcat(path2Pop,'PWI_',subject,'_1_ASL_1.nii');
P.pathPVgmMNI.nii=char(strcat(path2Pop,'PV_pGM_',subject,'_1.nii'));
P.pathPVwmMNI.nii=char(strcat(path2Pop,'PV_pWM_',subject,'_1.nii'));
% path to newly generated PVC files
P.pathASLORIMNI.nii=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_ORI.nii'));
P.pathPVCMNI.nii=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_PVC.nii'));
P.pathPVCmaskMNI.nii=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_PVCMask.nii'));
P.pathmaskMNI.nii=char(strcat(path2Pop,'BrainMask',subject,'.nii'));
P.pathPVCres.nii=char(strcat(path2ASL,'PVCres.nii'));
P.pathAtlas.nii=char(strcat(pwd,'\ArterialAtlas_level2.nii'));

P.pathASLNAT.gz=char(strcat(path2ASL,'ASL4D.nii.gz'));
P.pathPVgmNAT.gz=char(strcat(path2ASL,'PVgm.nii.gz'));
P.pathPVwmNAT.gz=char(strcat(path2ASL,'PVwm.nii.gz'));
% paths to newly generated PVC files and masks in native space
P.pathASLORINAT.gz=char(strcat(path2ASL,'ASL4D_ORI.nii.gz'));
P.pathPVCNAT.gz=char(strcat(path2ASL,'ASL_PVC.nii.gz'));
P.pathPVCmaskNAT.gz=char(strcat(path2ASL,'ASL_PVCMask.nii.gz'));
P.pathmaskNAT.gz=char(strcat(path2ASL,'BrainMask.nii.gz'));
% paths to raw ASL files (inc PV GM and PV WM) in MNI space
P.pathASLMNI.gz=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_1.nii.gz'));
P.pathPVgmMNI.gz=char(strcat(path2Pop,'PV_pGM_',subject,'_1.nii.gz'));
P.pathPVwmMNI.gz=char(strcat(path2Pop,'PV_pWM_',subject,'_1.nii.gz'));
% path to newly generated PVC files
P.pathASLORIMNI.gz=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_ORI.nii.gz'));
P.pathPVCMNI.gz=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_PVC.nii.gz'));
P.pathPVCmaskMNI.gz=char(strcat(path2Pop,'PWI_',subject,'_1_ASL_PVCMask.nii.gz'));
P.pathmaskMNI.gz=char(strcat(path2Pop,'BrainMask',subject,'.nii.gz'));
P.pathPVCres.gz=char(strcat(path2ASL,'PVCres.nii.gz'));
P.pathAtlas.gz=char(strcat(pwd,'\ArterialAtlas_level2.nii.gz'));