function [] = writeDescription(path2bids)
    %% Change to your own study as needed
    DD.Name = 'Hole in head Dementia Study (DTDS)';
    DD.BIDSVersion = '1.8.0 and 1.6.0 for ASL';
    DD.DatasetType = 'raw';
    DD.Authors = {'Alireza';'Gonzalo Maso Talou';...
        'Samantha Holdsworth';'Soroush Safaei'};
    DD.Acknowledgements = 'Thank you to all who contribute to tutorials and online documentation which enabled swift organization of the study';
    DD.HowToAcknowledge = 'Cite everything we publish, until then, help develop the project by getting invovled!';
    DD.Funding = {'Aotearoa Fellowship'};
    DD.EthicsApproval = 'EthicsRefNum0000';
    encoded=jsonencode(DD,PrettyPrint=true);
    fid = fopen(fullfile(path2bids,'\rawdata\dataset_description.json'),'w');
    fprintf(fid,'%s',encoded);
    fclose(fid);
end