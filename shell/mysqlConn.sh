#!/usr/bin/env bash

HOST=127.0.0.1
PORT=3306
USER=root
PASSWD=123456
DATABASE=word_world

# 执行sql 无需获取返回值，sql执行失败则脚本异常结束
# 参数1 完整的sql语句
function mysqlExecute {
    mysql -u"${HOST}" -P"${PORT}" -u"${USER}" -p"${PASSWD}" -D"${DATABASE}" -e "$1"
    if [[ $? -eq 0 ]]; then
        echo "exec sql succeed: "
        echo "$1"
    else
        echo "exec sql failed: "
        echo "$1"
        exit -1
    fi
}

# 执行sql 需获取返回值，sql执行失败则脚本异常结束
# 参数1 完整的select语句
function mysqlExecuteQuery {
    # 返回结果：-e带表头 -Ne不带表头
    rs=($(mysql -u"${HOST}" -P"${PORT}" -u"${USER}" -p"${PASSWD}" -D"${DATABASE}" -Ne "$1"))
    if [[ $? -eq 0 ]]; then
        # 打印查询结果中的每一个元素
        echo ${rs[*]}
    else
        echo "exec sql failed: "
        echo "$1"
        exit -1
    fi
}

# 获取指定行指定列的值
# 参数1 字段所在行数
# 参数2 字段所在列数
# 参数3 select总列数
# 参数4+ 查询结果数组
function getValueFromResult {
    local rowIndex
    local colIndex
    local column_num
    local rs
    rowIndex=$1
    colIndex=$2
    column_num=$3
    rs=($(echo "$@"))
    # 下标=总列数*(第几行-1)+第几列-1+非查询结果的其他参数个数
    idx=$(($column_num * ($rowIndex - 1) + $colIndex - 1 + 3))
    if [[ $((idx)) -le ${#rs[@]} ]]; then
        # 根据下标获取目标结果
        echo ${rs[$idx]}
    fi
}

# 计算查询返回结果数据行数
# 参数1 select总列数
# 参数2 查询结果数组
function getRowNumFromResult {
    local rs
    rs=($(echo "$@"))
    echo $(((${#rs[@]} - 1) / $1))
}
