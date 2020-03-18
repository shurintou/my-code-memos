#!/bin/bash

# 请事先阅读以下说明。
# 这是一个用于将JASS script中所有自定义触发器中的代码分割保存的脚本。
# 在使用之前，将由地图编辑器导出脚本（Export Scripts）功能导出的.j文件另存为functions.txt并放置到与本脚本同一目录下。
# 然后移除掉functions.txt中，//*  Triggers 之前，function InitCustomTriggers之后的代码。（因为这些代码并不存在于任一触发器中）
# 最后执行本脚本，查看output_functions文件夹检查结果。

# 定义输入文件和临时文件
input_file="functions.txt"
temp_file="temp_function.j"
output_dir="output_functions"

# 创建输出目录
mkdir -p "$output_dir"

# 清空临时文件
> "$temp_file"

# 变量初始化
inside_function=false
function_name=""

# 逐行读取输入文件
while IFS= read -r line; do
    # 检查函数声明行
    if [[ $line == function\ InitTrig_* ]]; then
        # 设置标志，表示进入函数声明
        inside_function=true
        # 提取函数名
        function_name=$(echo "$line" | awk '{print $2}' | sed 's/^InitTrig_//')
    elif [[ "$line" == "endfunction"* ]]; then
        if [[ $inside_function == true ]]; then
            echo "endfunction" >> "$temp_file"
            mv "$temp_file" "$output_dir/$function_name.j"
            > "$temp_file"
            inside_function=false
            continue
        fi
    fi
    # 写入到临时文件
    echo "$line" >> "$temp_file"
done < "$input_file"

# 删除临时文件
rm -f "$temp_file"