# localrc is your localrc :)  and .sh for syntax hilighting

live(){
if [ "$1" == "-l" ]
then 
    pwd > ~/.live
else
   cd `cat ~/.live`
fi
}

dr(){
    mkdir $1 && cd $1 
}

sdcard(){
    cd /storage/emulated/0
    export sdc="/storage/emulated/0"
}

tools(){
    cd /storage/emulated/0/tools
}

e64(){
    echo ${1}|base64 -d
}

j64(){
    for i in $(echo "${1}" |sed 's/\./\n/g')
    do echo "$i" | base64 -d 
    done
}

code(){
    if [ "${1}" ]
    then
        cd ~/code/${1}
    else
        cd ~/code/
    fi
}

allports(){
    sudo netstat -plnt
}
