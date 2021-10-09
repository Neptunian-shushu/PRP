import os
import re
import shutil
import pandas as pd
import patoolib
import rarfile


# 辅助函数 生成resample.agg 的参数字典
def extend_agg_method(agg_method_dict, all_columns=[]):
    agg_method_dict = agg_method_dict.copy()
    others_func = agg_method_dict.pop('others')

    # 设置其他列的默认行为
    for col_name in all_columns:
        agg_method_dict[col_name] = agg_method_dict.get(col_name, others_func)

    return agg_method_dict


def extract_from_rar(path, outpath):
    patoolib.extract_archive(path, outdir=outpath)


def extract_certain_files(path, outpath):
    rar = rarfile.RarFile(path)
    for file in rar.namelist():
        if file[-12:-7] in ['SH600', 'SH601', 'SH602', 'SH603', 'SZ000']:
            rar.extract(file, path=outpath)


def delete_dir(path):
    shutil.rmtree(path, ignore_errors=True)


def handle_one_day_data_rar(path=None, save_path=None, temp_dir=None,
                            
                            ):
    # 临时文件目录， 用于储存解压后的文件
    # 再合成完日级数据后自动删除
    # temp_dir = os.path.join(save_path, '_temp')
    os.makedirs(temp_dir, exist_ok=True)

    try:
        extract_from_rar(path, temp_dir)
    except Exception as e:
        raise e
    finally:
        print('continue')



# 输入年数据文件夹的路径
# 按原来文件夹的命名导出数据
def handle_one_year_daily_data(parent_dir=None, save_path=None,
                               dir_name=None, temp_dir='e:/test/_temp/',
                               **kwargs):
    # 提取年份
    year = re.findall('\d{4}', dir_name)[-1]
    save_dir_year = os.path.join(save_path, dir_name)
    #os.makedirs(save_dir_year, exist_ok='True')
    for root, dirs, files in os.walk(os.path.join(parent_dir, dir_name)):
        for file in files:
            if file.endswith('.zip') or file.endswith('.rar'):
                date = re.findall('\d{4,8}', file)[0]
                if len(date) > 4:
                    date = date[-4:]

                file_path = os.path.join(root, file)

                save_file_name = year + date + '.csv'
                save_file_path = os.path.join(save_dir_year, save_file_name)
                if not os.path.exists(save_file_path):
                    handle_one_day_data_rar(
                        path=file_path,
                        save_path=save_file_path,
                        temp_dir=temp_dir,
                        )
                #print('=========' + year + date + ' DONE ==========')


def handle_year_dir(parent_dir=None, save_path=None,
                    temp_dir=None, dir_name=None,
                    **kwargs):
    # 先清空临时文件夹 
    while True:
        try:
            delete_dir(temp_dir)
            break
        except:
            pass

    handle_one_year_daily_data(
        parent_dir=parent_dir,
        dir_name=dir_name,
        save_path=save_path,
        temp_dir=temp_dir,
        )


# In[]
freq = '1s'
# freq = '1t' 或者 '60s' 表示1分钟
# 设置聚合方式
# 没有设置的默认, others 表示其它未出现的列
agg_method = {
    'volume': 'sum',
    'amount': 'sum',
    'isbuy': 'mean',
    'others': 'last',  # 取最后一个, 可改成first变为取第一个值
}
label = 'left'  # 聚合后以左端点为区间标签
parent_dir = os.getcwd()+'\\GPSJ原始数据'  # 原始数据目录
save_path = os.getcwd()+'\\整理后数据'  # 处理后的数据保存地址

year_dir_list = [
    # '非股票的高频数据2017年1月-10月',
    # '高频原始数据2006',
    # '高频原始数据2007缺1.1-1.15',
    # '高频原始数据2008缺12.17-12.31',
    #    '高频原始数据2009',
    #    '高频原始数据2010',
    #    '高频原始数据2011',
    #    '高频原始数据2012',
    #    '高频原始数据2013',
    #    '高频原始数据2014',
    #    '高频原始数据2015',
    #    '高频原始数据2016',
    #    '高频原始数据2017',
    #    '高频原始数据2018',
    #    '高频原始数据2019',
        '高频原始数据2020',
        '高频原始数据2021'
]

for year_dir in year_dir_list:
    temp_dir= os.getcwd()+'\\解压后数据\\高频原始数据'+year_dir[-4:]
    handle_year_dir(
        parent_dir=parent_dir,
        save_path=save_path,
        temp_dir=temp_dir,
        dir_name=year_dir,
        freq=freq,
        label=label,
        agg_method=agg_method)
    print('============'+year_dir[-4:]+' done'+'============')

# %%
