# PRP
Materials for PRP in 2021 Autumn PRP program

_________

dataprocessing_1min.m: matlab文件用来按分钟处理csv数据，可以处理16列的以及24列的数据

dataprocessing_30sec.m: matlab文件用来按30秒处理csv数据

main.m：在主程序中调用dataprocessing函数进行数据处理，同时遍历所有文件夹，在原目录下生成处理后文件夹，并在其中以相同文件夹结构生成处理后数据。



____

Problems remain:

1. 对于数据里面那个isbuy，假如以每分钟为间隔处理数据，那么如果一分钟内isbuy有过1，而每分钟最后一个数据的isbuy为0，那么这应该算0还是算1？——留着就行
2. 现在貌似不能处理9：30以前的时间——不需要了
3. 如果半分钟数据由间断能否处理——可以
4. BP和SP数量为5或3的时候不能进行区分——需要进行修改

____

### 10/6 重新更新

shu-shu original code: 原来可用于处理1分钟的代码以及可处理30s数据但未完成的代码

zly code: 已按想要的数据格式进行封装，接下来需要处理的问题见changelog
