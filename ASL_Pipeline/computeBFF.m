function [BFF] = computeBFF(path2bids,subject,path2atlas) 
    %% compute blood flow fractions in MNI space. 
    P = makepaths(path2bids,subject);
    VascAtlas = xASL_io_Nifti2Im(path2atlas); %load vascular atlas MNI
    PWI=loadNift(P.pathASLMNI); %load original perfusion MNI
    PWIPVC=loadNift(P.pathPVCMNI); %load PVC ASL 
    mask=loadNift(P.pathmaskMNI); %load brain mask
    VascAtlsrshp = round(imresize3(VascAtlas,size(PWI),'Method','nearest')); %Resize atlas to xASL resolution
    PWI(isnan(PWI))=0;
    PWIPVC(isnan(PWIPVC))=0;
    for i=1:8
        BFF(i,1)=sum(PWI(mask==1 & VascAtlsrshp==i));
        BFF(i,2)=sum(PWIPVC(mask==1 & VascAtlsrshp==i));
    end
    BFF(:,3)=BFF(:,1)./sum(BFF(:,1));
    BFF(:,4)=BFF(:,2)./sum(BFF(:,2));

    %% Save json of fractions
    path2save=strcat(path2bids,'\derivatives\ExploreASL\',subject,'_1\ASL_1');
    bff=struct;
    bff.r_aca.sum = BFF(1,2);
    bff.r_aca.frac = BFF(1,4);
    bff.l_aca.sum = BFF(2,2);
    bff.l_aca.frac = BFF(2,4);
    
    bff.r_mca.sum = BFF(3,2);
    bff.r_mca.frac = BFF(3,4);
    bff.l_mca.sum = BFF(4,2);
    bff.l_mca.frac = BFF(4,4);
    
    bff.r_pca.sum = BFF(5,2);
    bff.r_pca.frac = BFF(5,4);
    bff.l_pca.sum = BFF(6,2);
    bff.l_pca.frac = BFF(6,4);
    
    bff.r_va.sum = BFF(7,2);
    bff.r_va.frac = BFF(7,4);
    bff.l_va.sum = BFF(8,2);
    bff.l_va.frac = BFF(8,4);
    cd(path2save)
    encoded=jsonencode(bff,"PrettyPrint",true);
    fid = fopen('bff.json','w');
    fprintf(fid,'%s',encoded);
    fclose(fid);