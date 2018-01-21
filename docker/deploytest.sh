#!/bin/bash
#!chmod +x ./deploytest.sh

echo a:程序的名称
echo b:程序的端口
echo c:映射到docker宿主的端口
echo d:docker相关的名字

a=程序的名称
b=程序的端口
c=映射到docker宿主的端口
d=docker相关的名字


while getopts "a:,b:,c:,d:" opt; do
  case $opt in
    a)
      echo "this is -a the arg is ! $OPTARG"
      a=$OPTARG
      ;;
    b)
      echo "this is -a the arg is ! $OPTARG"
      b=$OPTARG
      ;;
    c)
      echo "this is -a the arg is ! $OPTARG"
      c=$OPTARG
      ;;
    d)
      echo "this is -a the arg is ! $OPTARG"
      d=$OPTARG
      ;;
    \?)
      echo "参数不正确 $OPTARG"
      exit 1
      ;;
  esac
done

echo $a $b $c $d
echo ok