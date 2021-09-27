## CHANGELOG

### 2021/8/27

shu-shu：

1. dataprocess.m 能够只取每分钟内最后一个数据，还未实现空缺的时间填入上个时间的数据；
2. SH000001-1.csv 里面的数据目前存在一定问题，如SV、BV明显数据不对等。

### 2021/8/28

shu-shu:

1. dataprocess.m 将time与a统一为数组变量
2. dataprocess.m 可以将缺失的分钟的数据按上一个数据补齐
3. dataprocess.m volume累加
4. SH600000.csv 更换为浦发银行数据

### 2021/8/29

shu-shu:

1. dataprocess.m 删除多余数据项，如SP2、SV2等
2. dataprocess.m 去除秒时间
3. dataprocess.m 可以输出csv文件，输出文件名为‘原文件名-processed.csv’

### 2021/8/30

shu-shu:

1. dataprocess.m 可以改变时间间隔进行筛选，以分钟为单位
2. dataprocess.m 还需要确定选取的每个间隔的时间算在哪一个时间点上

### 2021/9/27

shu-shu:

由于本人一些离谱的撤销操作导致整个9月份的进展全部丢失。。

现在重新编辑

1. dataprocessing.m 用于调用进行处理数据，可以自行判断表格列数进行分别处理
2. main.m 在脚本中遍历所有需要处理的文件夹并调用dataprocessing函数进行数据处理
3. 所有数据处理基于2020年数据
4. dataprocessing.m volume按unit累加
