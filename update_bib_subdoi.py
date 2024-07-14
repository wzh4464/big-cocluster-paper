###
 # File: /latex/big-cocluster-paper/update_bib_subdoi.py
 # Created Date: Sunday, July 14th 2024
 # Author: Zihan
 # -----
 # Last Modified: Sunday, 14th July 2024 10:51:39 pm
 # Modified By: the developer formerly known as Zihan at <wzh4464@gmail.com>
 # -----
 # HISTORY:
 # Date      		By   	Comments
 # ----------		------	---------------------------------------------------------
###

import re

def replace_url_with_doi(input_file, output_file):
    # 读取原始 BibTeX 文件
    with open(input_file, 'r', encoding='utf-8') as file:
        content = file.read()

    # 正则表达式匹配每个 BibTeX 条目
    entries = re.split(r'@', content)
    updated_entries = []

    for entry in entries:
        if 'DOI' in entry:
            # 提取 DOI
            doi_match = re.search(r'DOI\s*=\s*{([^}]+)}', entry)
            if doi_match:
                doi = doi_match.group(1).strip()
                doi_url = f'https://doi.org/{doi}'
                
                # 替换 URL 字段
                entry = re.sub(r'URL\s*=\s*{[^}]+}', f'URL = {{{doi_url}}}', entry)

        updated_entries.append(entry)

    # 将修改后的条目组合回一个单一字符串
    updated_content = '@'.join(updated_entries)

    # 写入输出文件
    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(updated_content)

# 使用示例
input_filename = 'main_bibtex.bib'
output_filename = 'updated.bib'
replace_url_with_doi(input_filename, output_filename)
