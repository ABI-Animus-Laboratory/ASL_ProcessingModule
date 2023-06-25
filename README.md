# ExploreASL_Animus
Runs [ExploreASL](https://github.com/ExploreASL/ExploreASL/tree/main) to collect blood flow fractions and normalize ASL for use in the cerebral brain model pipeline.

## Dependencies
* [ExploreASL](https://github.com/ExploreASL/ExploreASL/tree/main)
* a BIDS organized dataset
* Vascular Atlas in MNI space (included in download, from [here](https://www.nitrc.org/projects/arterialatlas)

## How to use
The general processing pipeline is as follows 
![](https://github.com/ABI-Animus-Laboratory/ExploreASL_Animus/blob/main/images/ASL%20Pipeline.png)

The only code to run is 
```matlab
ASLPipeline.m
```
Update the first few lines 
```matlab
path2bids='C:\Users\sdem348\Desktop\TestASLPipe'; %full path to BIDS ROOT
path2xasl='C:\Users\sdem348\Desktop\ExploreASL-1.10.1'; %the full path
subject="sub-#"; %In this case 001,015 etc
```

If you wish to visualize the partial volume changes, you can optionally run 
```matlab
PVCdifferences.m
```
This will throw up a plot like so, which should let you know it all worked
![](https://github.com/ABI-Animus-Laboratory/ExploreASL_Animus/blob/main/images/PVC_ASL.png)

Approximate processing time is 20 minutes per subject for high quality reconstruction and MNI registration. If you wish to change the pipeline parameters (Bspline or affine registrations for ASL to T1w) look into 
```matlab
writedataPar.m
```
where all pipeline variables are editable. refer to this [source](https://exploreasl.github.io/Documentation/1.10.0/ProcessingParameters/), for in depth descriptions of all potential modifiers.

## How to cite
The following provides an example as how to correctly cite ExploreASL and its third-party tools. The versions of the included third-party tools are described in [CHANGES.md](https://github.com/ExploreASL/ExploreASL/blob/main/CHANGES.md) for each ExploreASL release. The bare minimum of references (`refs`) are `ref1` and `ref2`.

>The data were analysed using ExploreASL `ref1` version x.x.x `ref2`, including SPM12 version xxxx `ref3`, CAT12 version xxxx`ref4`, and LST version x.x.x`ref5`. This Matlab-based software was used with Matlab (MathWorks, MA, USA) version x.x (yearx)`ref6`.

### Potential ExploreASL References

The release numbers of ExploreASL (e.g. `1.10.1`).

1. The [ExploreASL paper](https://www.sciencedirect.com/science/article/pii/S1053811920305176), describing the full pipeline and decisions for processing steps.
2. The Zenodo DOI for the actual ExploreASL release used to analyse the data, e.g. the [latest release](https://doi.org/10.5281/zenodo.3905262)).
3. The SPM12 references [Ashburner, 2012](https://doi.org/10.1016/j.neuroimage.2011.10.025) & [Flandin and Friston, 2008](https://doi.org/10.4249/scholarpedia.6232). Note that the SPM version (e.g. `7219`) is adapted and extended for use with ExploreASL.
4. The CAT12 reference [Gaser, 2009](https://doi.org/10.1016/S1053-8119(09)71151-6). Note that the CAT12 version (e.g. `1364`) is adapted for use with ExploreASL.
5. The LST references [Schmidt, 2017](https://www.statistical-modelling.de/LST_documentation.pdf) & [de Sitter, 2017](https://doi.org/10.1016/j.neuroimage.2017.09.011). Note that the LST version (e.g. `2.0.15`) is adapted for use with ExploreASL.
6. Matlab publishes a [release](https://www.mathworks.com/help/matlab/release-notes.html) twice yearly. You can provide the release number (e.g. `9.4`) or year number (e.g. `2018a`), or both.

### Arterial Atlas citation
To cite the vascular atlas used, cite
[Atlas from Nitrc](https://www.nitrc.org/doi/landing_page.php?table=groups&id=1498&doi=10.25790/bml0cm.109)

Recommended citation is 
>Faria, A., & LIU, C. (2021, Feb 26). Arterial Atlas [Tool/Resource.]. Washington: NITRC. https://www.nitrc.org/doi/landing_page.php?table=groups&id=1498

