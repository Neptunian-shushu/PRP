
			微盛投資  整理提供
			www.wstock.net
			www.ws-data.com



說明：把分筆數據壓縮文件拷貝到硬盤中，解壓縮速度更快。


滬深市場休市日期一覽：
http://www.wstock.net/wstock/sholiday.htm
http://www.ws-data.com/wstock/sholiday.htm





备注：
將光盤中的全部數據文件拷貝到硬盤中，然後采用命令行方式解壓縮，可直接從全部rar文件中批量提取 指定股票代码（支持通配符） 的數據：

示意代碼1（只提取所有文件[包括子文件夾中的文件] 上海綜合指數 SH000001 的數據）：
"C:\Program Files\WinRAR\WINRAR.exe" x -r G:\SHSZData\FB5\*.rar *SH000001* G:\Temp\

示意代碼2（提取所有文件[包括子文件夾中的文件] 上海指數[包括行業分類指數] 的數據）：
"C:\Program Files\WinRAR\WINRAR.exe" x -r G:\SHSZData\FB5\*.rar *SH000* G:\Temp\


示意代碼3，提取 SH600839、SZ000036 這兩只股票的數據：
"C:\Program Files\WinRAR\WINRAR.exe" x -r G:\SHSZData\FB5\*.rar *SH600839* *SZ000036* G:\Temp\


示意代碼4，提取 需要的 58只股票（例如自己的自選股） 的數據：
首先把這58只股票代碼寫入 myStocks.txt 文件，每行一個股票代碼，前後加*，例如
*SH600009*
*SZ000036*
然後在命令行中執行下面的語句：
"C:\Program Files\WinRAR\WINRAR.exe" x -r -n@myStocks.txt G:\SHSZData\FB5\*.rar G:\Temp\


