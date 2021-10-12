# PRP
Materials for PRP in 2021 Autumn PRP program

____

### 使用流程

1. 只看主文件夹里的内容。
2. 首先执行python exactfile.py 进行解压操作，该步骤将所有GPSJ原始数据中的文件解压到解压后数据文件夹中。
3. 然后执行matlab文件main.m进行数据处理，该步骤可将解压后数据文件夹中所有数据进行处理，并输出到处理后数据文件夹中。
4. 得到想要的处理数据啦！

____

### HPC平台使用

#### 在线远程桌面

登陆网址：https://studio.hpc.sjtu.edu.cn/

主用户名：aemhwx

密码：PBm5A!VD

子用户：shu-shu

密码：shubohan020904



____

### 10/6 重新更新

shu-shu original code: 原来可用于处理1分钟的代码以及可处理30s数据但未完成的代码

zly code: 已按想要的数据格式进行封装，接下来需要处理的问题见changelog

test：测试cd和直接读取路径哪种方式速度更快：直接读取路径更快，但是快的不多



### 10/9

extractfile.py: 可以解压一定格式年份的数据（目测除了2006应该都行）

main.m：大体上已经可以配合进行extractfile.py进行处理



```
cat hhh.txt | xargs --max-args=1 --max-procs=5 --replace=% rsync --archive --partial E:/hhh.txt% aemhwx@data.hpc.sjtu.edu.cn:/lustre/home/acct-aemhwx/aemhwx/Desktop/
```

