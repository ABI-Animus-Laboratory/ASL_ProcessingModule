function [] = writedataPar(subregexp)
%% Import settings
dataPar.x.dataset.name = "";
%Name of Subject/s to process. Coded for 1 at a time presently.
dataPar.x.dataset.subjectRegexp = strcat('^(',subregexp,')(?:_\\w+)?$');
dataPar.x.dataset.exclusion = {}; %exclude none
dataPar.x.external.bAutomaticallyDetectFSL = false; %keep false
dataPar.x.external.FSLPath = ""; %keep empty
% dataPar.x.GUI.StudyRootPath = "C:\\Users\\sdem348\\Desktop\\TestASLPipe";
% dataPar.x.GUI.SUBJECTS = {"sub-002"};
% dataPar.x.GUI.EASLPath = "C:\\Users\\sdem348\\Desktop\\TestASLPipe\\code\\ExploreASL-1.10.1";
% dataPar.x.GUI.EASLType = "Github";
% dataPar.x.GUI.MATLABRuntimePath = "";
%% ASL Segment
dataPar.x.modules.asl.M0_conventionalProcessing = 0; %Default
dataPar.x.modules.asl.M0_GMScaleFactor = 1; %Default
dataPar.x.modules.asl.motionCorrection = 0; %Default =1, only applies to time series
dataPar.x.modules.asl.SpikeRemovalThreshold = 0.01; %Only applies to motion correction
dataPar.x.modules.asl.bRegistrationContrast = 2; %IMPORTANT: Registration contrast, registers pseudo ASL with ASL
dataPar.x.modules.asl.bAffineRegistration = 0; %0 = affine registration disabled, 1 = affine registration enabled, 2 = affine registration automatically chosen based on spatial CoV of PWI.
dataPar.x.modules.asl.bDCTRegistration = 0;%DiscreteCosineReg. Not needed, 0 = DCT registration disabled 1 = DCT registration enabled if affine enabled and conditions for affine passed, 2 = DCT enabled as above, but use PVC on top of it to get the local intensity scaling right. 
dataPar.x.modules.asl.bRegisterM02ASL = 0; %we don't have M0
dataPar.x.modules.asl.bUseMNIasDummyStructural = 0;%default, will have structural T1w always
dataPar.x.modules.asl.bPVCNativeSpace = 1; %IMPORTANT Activate PVC, this will do GM & WM PVC in native space, but importantly, resample the PV maps into ASL resolution so we can use them for functions
dataPar.x.modules.asl.bPVCNativeSpaceKernel = [5,5,1]; %recommended kernel
dataPar.x.modules.asl.bPVCGaussianMM = 0; %Uses Gaussian weighting instead of Kernel. We'll go with Asllani's original method
dataPar.x.modules.asl.MakeNIftI4DICOM = true; %Save DICOM capable resampled images of processed ASL
dataPar.x.modules.asl.ApplyQuantification = [0,0,0,0,0,0]; %should this be here?
%% Structural Segment
dataPar.x.modules.bRunLongReg = 0;
dataPar.x.modules.bRunDARTEL = 0;
dataPar.x.modules.WMHsegmAlg = "LPA";
dataPar.x.modules.structural.bSegmentsSPM12 = 0; %Run CAT12
dataPar.x.modules.structural.bHammersCAT12 = 0;
dataPar.x.modules.structural.bFixResolution = false; %Don't resample to CAT12, our resolution is fine.
dataPar.x.modules.population.bNativeSpaceAnalysis = true;
%% Quantification Segment (not needed unless dealing with raw ASL)
%Q does not need to be provided since we are not quantifying any ASL
% dataPar.x.Q.SliceReadoutTime = 38;
% dataPar.x.Q.bUseBasilQuantification = false; %default
% dataPar.x.Q.Lambda = 0.9; %default
% dataPar.x.Q.T2art = 50; %default at 3T
% dataPar.x.Q.BloodT1 = 1650;%default at 3T
% dataPar.x.Q.TissueT1 = 1240;%default at 3T
% dataPar.x.Q.nCompartments = 1;% can set to 2 for BBB ASL
dataPar.x.Q.ApplyQuantification = [0,0,0,0,0,0];
% dataPar.x.Q.SaveCBF4D = false;
%% General Settings
dataPar.x.settings.Quality = 1; %Check 0 vs 1. Looks like low quality is actually better
dataPar.x.settings.DELETETEMP = 1;
dataPar.x.settings.SkipIfNoFlair = 0;
dataPar.x.settings.SkipIfNoASL = 0;
dataPar.x.settings.SkipIfNoM0 = 0;
%% Atlases
dataPar.x.S.bMasking = [0,0,0,1]; %Only apply vascular (3) and whole brain mask (4)
dataPar.x.S.Atlases = {'TotalGM','DeepWM','MNI_Structural'};
%% encoding
encoded=jsonencode(dataPar,"PrettyPrint",true);
fid = fopen('dataPar.json','w');
fprintf(fid,'%s',encoded);
fclose(fid);