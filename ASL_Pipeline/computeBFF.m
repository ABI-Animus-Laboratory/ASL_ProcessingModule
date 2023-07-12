function [BFF] = computeBFF(path2bids,subject,path2atlas) 
    %% compute blood flow fractions in MNI space. 
    % Presently uses the PVC ASL in MNI space to compute BFF
    P = makepaths(path2bids,subject);
    VascAtlas = xASL_io_Nifti2Im(path2atlas); %load vascular atlas MNI
    PWI=loadNift(P.pathASLMNI); %load original perfusion MNI
    PWIPVC=loadNift(P.pathPVCMNI); %load PVC ASL 
    mask=loadNift(P.pathmaskMNI); %load brain mask
    VascAtlsrshp = round(imresize3(VascAtlas,size(PWI),'Method','nearest')); %Resize atlas to xASL resolution
    PWI(isnan(PWI))=0;
    PWIPVC(isnan(PWIPVC))=0;
    PWI(PWI<0)=0;
    PWIPVC(PWIPVC<0)=0;
    VesselNames={'MCA_L';'MCA_R';'ACA_L';'ACA_R';'PCA_L';'PCA_R';'Ventricle_L';'Ventricle_R';'VB_L';'VB_R'};
    %AtlasOrder = [3 4 1 2 5 6 9 10 7 8]; %MCAL MCAR ACAL ACAR PCAL PCAR VL VR VBL VBR
    AtlasOrder = [3 4 1 2 5 6 9 10 7 8]; %MCAL MCAR ACAL ACAR PCAL PCAR VL VR VBL VBR
    for i=1:10
        territory=AtlasOrder(i);
        BFF(i,1)=sum(PWI(mask==1 & VascAtlsrshp==territory)); %Column 1 without PVC
        BFF(i,2)=sum(PWIPVC(mask==1 & VascAtlsrshp==territory)); %Column 2 with PVC
        BFF(i,5)=mean(PWI(mask==1 & VascAtlsrshp==territory)); %Column 1 without PVC
        BFF(i,6)=mean(PWIPVC(mask==1 & VascAtlsrshp==territory)); %Column 2 with PVC
    end
    BFF(:,3)=BFF(:,1)./sum(BFF(:,1));
    BFF(:,4)=BFF(:,2)./sum(BFF(:,2));
	Table = table('Size',[10,4],'VariableTypes',{'cellstr','double','double','double'},'VariableNames',["Flow","Sum of voxel values","Fraction","Mean"]);
    Table.('Flow') = VesselNames;
    Table.('Sum of voxel values') = BFF(:,2);
    Table.('Fraction') = BFF(:,4);
    Table.('Mean') = BFF(:,6);
    %% Save json of fractions
    path2save=strcat(path2bids,'\derivatives\ExploreASL\',subject,'_1\ASL_1');
    writetable(Table,fullfile(path2save,'ASL_ModelConfig.csv'));