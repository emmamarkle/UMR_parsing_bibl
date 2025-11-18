#!/bin/sh
#SBATCH --job-name=bibl_generator
#SBATCH --output=bibl_generator_%j.out
#SBATCH --error=bibl_generator_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G

source /cm/shared/apps/amh-conda/etc/profile.d/conda.sh
conda activate base
conda activate BIBL

unset PYTHONPATH

INPUT_FILE="/home/common/ACNLP/umr_parsing/BiBL_model/BiBL/test.txt"

filename=$(basename "$INPUT_FILE")
dataset_name=$(echo "$filename")  

OUTPUT_FILE="/home/common/ACNLP/umr_parsing/BiBL_model/BiBL/test_output.txt"

GOLD_FILE="/home/common/ACNLP/umr_parsing/BiBL_model/BiBL/gold.txt"

python /home/common/ACNLP/umr_parsing/BiBL/bin/predict_amrs.py \
    --datasets "$INPUT_FILE" \
    --gold-path "$GOLD_FILE" \
    --pred-path "$OUTPUT_FILE" \
    --checkpoint /home/common/ACNLP/umr_parsing/BiBL_model/BiBL/best-smatch_checkpoint_2_0.3371.pt \
    --beam-size 3 \
    --batch-size 100 \
    --device cuda \
    --penman-linearization --use-pointer-tokens


