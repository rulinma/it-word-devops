#!/bin/bash

# sh shell/warm_words.sh

. shell/mysqlConn.sh

prefix=/Users/rollin/ai_word/word/git/docs/dict/images/

echo $prefix

# curl https://www.xianglesong.com/word/the
# select列数
column_num=2

selectSql="select id, word from word_images"

# 调用方法执行sql，打印出sql执行结果但不获取返回值
mysqlExecute "$selectSql"
# 用数组接收查询返回值
result=($(mysqlExecuteQuery "$selectSql"))

# 计算查询返回结果数据行数
row_num=$(getRowNumFromResult ${column_num} ${result[*]})
echo "rownum:" $row_num

for ((i = 1; i <= $row_num; i = i + 1)); do
    # 获取第一列的值
    id=$(getValueFromResult $((i)) 1 $column_num ${result[*]})
    # 获取第二列的值
    word=$(getValueFromResult $((i)) 2 $column_num ${result[*]})
    # echo "id: $id, name: $word"
    # echo $word
    echo $prefix$word".jpg"
    # cp $prefix$word".jpg" /tmp/images
    convert /tmp/images/$word.jpg -trim -resize 250x250 /tmp/images/$word.jpg
    # sleep 3
done
