import os

# dataset should be place in images folder
dataset_name = "lab"
print(f"dataset_name: {dataset_name}")

feat_extract_cmd = f"colmap feature_extractor --image_path /home/images/{dataset_name}/input"\
                                           f" --database_path /home/images/{dataset_name}/database.db"

feat_match_cmd = f"colmap exhaustive_matcher --database_path /home/images/{dataset_name}/database.db"

os.makedirs(f"/home/images/{dataset_name}/sparse")

mapper_cmd = f"colmap mapper --database_path /home/images/{dataset_name}/database.db"\
                          f" --image_path /home/images/{dataset_name}/input"\
                          f" --output_path /home/images/{dataset_name}/sparse"
                        
undistort_cmd = f"colmap image_undistorter --image_path /home/images/{dataset_name}/input"\
                                        f" --input_path /home/images/{dataset_name}/sparse/0"\
                                        f" --output_path /home/images/{dataset_name}/dense"

foldcreate_cmd = f"mkdir /home/images/{dataset_name}/dense/sparse/0"
cp_cmd1 = f"cp /home/images/{dataset_name}/dense/sparse/cameras.bin /home/images/{dataset_name}/dense/sparse/0/"
cp_cmd2 = f"cp /home/images/{dataset_name}/dense/sparse/images.bin /home/images/{dataset_name}/dense/sparse/0/"
cp_cmd3 = f"cp /home/images/{dataset_name}/dense/sparse/points3D.bin /home/images/{dataset_name}/dense/sparse/0/"

exit_code1 = os.system(feat_extract_cmd)
exit_code2 = os.system(feat_match_cmd)
exit_code3 = os.system(mapper_cmd)
exit_code4 = os.system(undistort_cmd)
exit_code5 = os.system(foldcreate_cmd)

exit_code6 = os.system(cp_cmd1)
exit_code7 = os.system(cp_cmd2)
exit_code8 = os.system(cp_cmd3)
