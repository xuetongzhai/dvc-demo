clear

project_dir = '../';

load([project_dir 'data/prepared/raw.mat']);
ROC = nirs.testing.ChannelStatsROC;
dataset = struct("data", raw, "truth", truth);
ROC.dataset = dataset;
roc = ROC.run(length(raw));
output_dir = [project_dir 'data/roc_stats'];
if exist(output_dir, "dir") ~= 7
    mkdir(output_dir)
end
save([project_dir 'data/roc_stats/roc.mat'], "roc", "-mat")
nirs.util.wipe_mat_header([project_dir 'data/roc_stats/roc.mat'])
