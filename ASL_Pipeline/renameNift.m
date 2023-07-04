function [] = renameNift(P1,P2)
try
    movefile(P1.gz,P2.gz)
catch
    movefile(P1.nii,P2.nii)
end