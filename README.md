# PRP
Materials for PRP in 2021 Autumn PRP program

_________

dataprocessing.m: matlab文件用来处理csv数据，可以处理16列的以及24列的数据

main.m：在主程序中调用dataprocessing函数进行数据处理，同时遍历所有文件夹，在原目录下生成处理后文件夹，并在其中以相同文件夹结构生成处理后数据。

____

Problems remain:

1. 对于数据里面那个isbuy，假如以每分钟为间隔处理数据，那么如果一分钟内isbuy有过1，而每分钟最后一个数据的isbuy为0，那么这应该算0还是算1？
