BENCHMARK=$1
SHOT=$2
PI=$3
GPU=$4
FILENAME=$5

# Pascal-5i和Pascal-10i的介绍: https://blog.csdn.net/qq_41609728/article/details/138164713?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-138164713-blog-126575439.235^v43^pc_blog_bottom_relevance_base5&spm=1001.2101.3001.4242.1&utm_relevant_index=3
if [ ${BENCHMARK} == "pascal5i" ]
then
  DATA="pascal"
  SPLITS="0 1 2 3"
elif [ ${BENCHMARK} == "coco20i" ]
then
  DATA="coco"
  SPLITS="0 1 2 3"
elif [ ${BENCHMARK} == "pascal10i" ]
then
  DATA="pascal"
  SPLITS="10 11"
fi

printf "%s\nbenchmark: ${BENCHMARK}, shot: ${SHOT}, pi_estimation_strategy: ${PI}\n\n" "---" >> ${FILENAME}
for SPLIT in $SPLITS
do
  python3 -m src.test --config config/${DATA}.yaml \
            --opts split ${SPLIT} \
              shot ${SHOT} \
              pi_estimation_strategy ${PI} \
              n_runs 5 \
              gpus ${GPU} \
              |& tee -a ${FILENAME}
  printf "\n" >> ${FILENAME}
done
