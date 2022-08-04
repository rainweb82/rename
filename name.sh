#需自动过滤的关键词，用空格隔开（如需替换关键，可用逗号分割）
noword="_-_ 喜马拉雅 _免费在线阅读收听下载 《 》,_ （ ）,_ 【 】,_ ___,_ __,_"

#处理后原始文件的保存目录
oldml="已处理"

#需替换的中文数字
allnum="九十九,99 九十八,98 九十七,97 九十六,96 九十五,95 九十四,94 九十三,93 九十二,92 九十一,91 九十,90 八十九,89 八十八,88 八十七,87 八十六,86 八十五,85 八十四,84 八十三,83 八十二,82 八十一,81 八十,80 七十九,79 七十八,78 七十七,77 七十六,76 七十五,75 七十四,74 七十三,73 七十二,72 七十一,71 七十,70 六十九,69 六十八,68 六十七,67 六十六,66 六十五,65 六十四,64 六十三,63 六十二,62 六十一,61 六十,60 五十九,59 五十八,58 五十七,57 五十六,56 五十五,55 五十四,54 五十三,53 五十二,52 五十一,51 五十,50 四十九,49 四十八,48 四十七,47 四十六,46 四十五,45 四十四,44 四十三,43 四十二,42 四十一,41 四十,40 三十九,39 三十八,38 三十七,37 三十六,36 三十五,35 三十四,34 三十三,33 三十二,32 三十一,31 三十,30 二十九,29 二十八,28 二十七,27 二十六,26 二十五,25 二十四,24 二十三,23 二十二,22 二十一,21 二十,20 十九,19 十八,18 十七,17 十六,16 十五,15 十四,14 十三,13 十二,12 十一,11 十,10 ,九,9 ,八,8 ,七,7 ,六,6 ,五,5 ,四,4 ,三,3 ,二,2 ,一,1"

#生成需处理的目录列表(含文件的目录)
function gitlist()
{
printf "\033[0m 正在检测目录内文件，请稍后...\r"
allfile=""
data=`ls -R`
data=`echo $data`
data=${data//:/\/} 
data=${data//.\//} 
data=${data//\/ DM/.DM} 
for list in $data
do
	array=(${list//./ })
	if [[ ${#array[@]} -eq 3 ]]
	then
		allfile=$allfile" "$list
	fi
done
}

#代码开始
gitlist
if [[ ! $allfile ]]
then
	echo -e "\033[31m"未检测到可操作的文件，请检查后重试！"\033[0m"
else
	#获取文件输出目录名
	echo -e "\033[31m"
	read -t 30 -p "请输入导出目录名（默认为Output）:" mlname
	echo -e "\033[0m"
	if [[ ! $mlname ]]
	then
		mlname="Output"
	fi
	mlname=${mlname// /_} 
	mkdir -p $mlname
	mkdir -p $oldml
	#过滤目录中的关键词
	for list in $allfile
	do
		array=(${list//./ })
		name=${array[0]}
		newname=${array[0]}
		#替换中文数字
		for num in $allnum
		do
			tmpnum=(${num//,/ })
			newname=${newname//${tmpnum[0]}/${tmpnum[1]}} 
		done
		#替换需过滤的关键词
		for word in $noword
		do
			tmpword=(${word//,/ })
			newname=${newname//${tmpword[0]}/${tmpword[1]}} 
		done
		#判断是否需要改名
		if [ $name != $newname ]
		then
			echo -e "重命名 \033[35m"${name:0:20}"...\033[0m"
			mv $name $newname
			name=$newname
		fi
		#复制文件到新目录并改名
		echo -e "复制 \033[32m"${name:0:20}"...\033[0m"
		cp ./$name/${array[1]}.${array[2]} ./$mlname/$name.${array[2]}
		mv ./$name ./$oldml/$name
	done
fi