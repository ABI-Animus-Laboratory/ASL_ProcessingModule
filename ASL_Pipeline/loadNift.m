function Mat = loadNift(P)
try
    Mat = xASL_io_Nifti2Im(P.nii);
catch
    Mat = xASL_io_Nifti2Im(P.gz);
end