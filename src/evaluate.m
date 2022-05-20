clear

project_dir = '../';

load([project_dir '/data/roc_stats/roc.mat']);
aucs = roc.auc;

scores = struct("auc_hbo", aucs(1), "auc_hbr", aucs(2), "auc_joint", aucs(3));
fileID = fopen([project_dir 'scores.json'], 'w');
fprintf(fileID, jsonencode(scores,PrettyPrint=true));
fclose(fileID);

roc_names = ["roc_hbo", "roc_hbr", "roc_joint"];
fpr_names = ["fpr_hbo", "fpr_hbr", "fpr_joint"];
for j = 1:3
    pvals_hbo = roc.pvals(:, j);
    truth_hbo = roc.truth(:, j);
    [tp,fp,th] = nirs.testing.roc( truth_hbo, pvals_hbo );
    roc_structs = [];
    for i = 1:length(tp)
        roc_structs = [roc_structs, struct("fpr", fp(i), "tpr", tp(i), "threshold", th(i))];
    end
    roc_output = struct(roc_names(j), roc_structs);
    fileID = fopen([project_dir convertStringsToChars(roc_names(j)) '.json'], 'w');
    fprintf(fileID, jsonencode(roc_output,PrettyPrint=true));
    fclose(fileID);

    fpr_structs = [];
    for i = 1:length(tp)
        fpr_structs = [fpr_structs, struct("p_hat", th(i), "fpr", fp(i))];
    end
    fpr_output = struct(fpr_names(j), fpr_structs);
    fileID = fopen([project_dir convertStringsToChars(fpr_names(j)) '.json'], 'w');
    fprintf(fileID, jsonencode(fpr_output,PrettyPrint=true));
    fclose(fileID);
end
