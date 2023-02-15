#!/bin/bash
git status
 
read -r -p "是否继续提交? [Y/n] " input
 
case $input in
    [yY][eE][sS]|[yY])
        echo "继续提交";

        echo "开始替换图片路径为github pages";
        file_list=` find /Users/yanghao/docs/ -name "*.md" `
 
        for i in $file_list
            do
            sed -i "" 's#../all_images#all_images#g' $i
        done
        echo "替换图片路径为github pages结束";

        #前后给点时间
        sleep 2;

        git add -A ;
        git commit -m $1 ;
        git push -u origin $2 ;

        sleep 2;

        echo "开始替换图片路径为本地相对路径";
        file_list=` find /Users/yanghao/docs/ -name "*.md" `
 
        for i in $file_list
            do
            sed -i "" 's#all_images#../all_images#g' $i
        done
        echo "替换图片路径为本地相对路径结束";
        exit 1
        ;;
    [nN][oO]|[nN])
        echo "中断提交"
        exit 1
            ;;

    *)
    echo "输入错误，请重新输入"
    ;;
esac
