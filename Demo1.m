data_names = {'2G','3G','AGG','Flame','Spiral','2G_unbalance','S1','S2','UB','R15'};
 
%%
Result_all = [];

for name_id=1:length(data_names)
    dataName = data_names{name_id};
    load(['Datasets\',dataName,'.mat']);
    [N,dim] = size(data); 
    nClass=length(unique(annotation_data));
    
    for cut_method = 1
        theta = 0.01;
        [Label, W_ori,I_ori,K_array,rho,roots_idx] = NDC(data,nClass,theta,cut_method);
        
         disp(['dataName',': ',dataName, ';  ','cut_method',': ',num2str(cut_method)])
        if any(isnan(annotation_data))
            id_Nan = isnan(annotation_data);
            annotation_data = annotation_data(~id_Nan);
            Label = Label(~id_Nan);
        end
        if min(Label) == 0
            Label = Label + 1;
        end
        
        [NMI,ARI]= NMI_ARI(Label,annotation_data);
        
        record_num =  length(Result_all) + 1;
        Result_all(record_num).data_name = dataName;
        Result_all(record_num).N = N;
        Result_all(record_num).DIM = dim;
        Result_all(record_num).cut_method = cut_method;
        Result_all(record_num).NMI = NMI;
        Result_all(record_num).ARI = ARI;
    end
end
disp(' ******************** All Results ************************ ')
if exist('Result_all','var')
    disp(struct2table(Result_all, 'AsArray', true)) %struct2table function may not exist in low matlab version; if so, then use the following commented codes
end
