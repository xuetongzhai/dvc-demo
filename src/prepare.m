clear
project_dir = '../';
params = yaml.loadFile([project_dir 'params.yaml']);
seed = params.prepare.seed;
N = params.prepare.N;
rng(seed);
raw = repelem(nirs.core.Data, N ,1);
truth = [];
for i = 1:N
    [raw(i), truth_tmp] = nirs.testing.simData();
    truth = [truth, truth_tmp];
end
output_dir = [project_dir 'data/prepared'];
if exist(output_dir, "dir") ~= 7
    mkdir(output_dir)
end
save([project_dir 'data/prepared/raw.mat'], "raw", "truth", "-mat")
nirs.util.wipe_mat_header([project_dir 'data/prepared/raw.mat'])