```bash
while read sample;
do
head -1 ~/DEploid-IBD-Benchmark/simulation/readCounts/${sample}_ref.txt > ${sample}_Pf3D7_14_v3_ref.txt
grep "Pf3D7_14_v3" ~/DEploid-IBD-Benchmark/simulation/readCounts/${sample}_ref.txt >> ${sample}_Pf3D7_14_v3_ref.txt
gzip ${sample}_Pf3D7_14_v3_ref.txt

head -1 ~/DEploid-IBD-Benchmark/simulation/readCounts/${sample}_alt.txt > ${sample}_Pf3D7_14_v3_alt.txt
grep "Pf3D7_14_v3" ~/DEploid-IBD-Benchmark/simulation/readCounts/${sample}_alt.txt >> ${sample}_Pf3D7_14_v3_alt.txt
gzip ${sample}_Pf3D7_14_v3_alt.txt
done < sampleNames
```
