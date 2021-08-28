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
