#!/usr/bin/bash
# Colours have names too. Stolen from Arch wiki
txtblk=$'\e[0;30m' # Black - Regular
txtred=$'\e[0;31m' # Red
txtgrn=$'\e[0;32m' # Green
txtylw=$'\e[0;33m' # Yellow
txtblu=$'\e[0;34m' # Blue
txtpur=$'\e[0;35m' # Purple
txtcyn=$'\e[0;36m' # Cyan
txtwht=$'\e[0;37m' # White
bldblk=$'\e[1;30m' # Black - Bold
bldred=$'\e[1;31m' # Red
bldgrn=$'\e[1;32m' # Green
bldylw=$'\e[1;33m' # Yellow
bldblu=$'\e[1;34m' # Blue
bldpur=$'\e[1;35m' # Purple
bldcyn=$'\e[1;36m' # Cyan
bldwht=$'\e[1;37m' # White
unkblk=$'\e[4;30m' # Black - Underline
undred=$'\e[4;31m' # Red
undgrn=$'\e[4;32m' # Green
undylw=$'\e[4;33m' # Yellow
undblu=$'\e[4;34m' # Blue
undpur=$'\e[4;35m' # Purple
undcyn=$'\e[4;36m' # Cyan
undwht=$'\e[4;37m' # White
bakblk=$'\e[40m'   # Black - Background
bakred=$'\e[41m'   # Red
badgrn=$'\e[42m'   # Green
bakylw=$'\e[43m'   # Yellow
bakblu=$'\e[44m'   # Blue
bakpur=$'\e[45m'   # Purple
bakcyn=$'\e[46m'   # Cyan
bakwht=$'\e[47m'   # White
txtrst=$'\e[0m\]'    # Text Reset


# Prompt colours
atC="${txtpur}"
nameC="${txtpur}"
hostC="${txtpur}"
pathC="${txtgrn}"
gitC="${txtpur}"
pointerC="${txtgrn}"
normalC="${txtwht}"


txtgrn=$'\[\e[0;32m\]' # Green

echo "hello ${bldgrn} It is a Green ${txtwht} white"




rec_count=0

tree-rec(){
################## It is a Rec
obj_id=$1

#if [ "$( git cat-file -t ${obj_id} )" == "tree" ]
#then
#    echo "It is a Tree Recertion "
#    tree-rec "${obj_id}"
#    git cat-file -p $1
#fi

for rec in $(git cat-file -p ${obj_id} |awk '{print $3}')
do
    if [ "$( git cat-file -t ${rec} )" == "tree" ]
    then
        let "rec_count=rec_count+1"
        echo " ${txtcyn} It is a Tree Recertion We got a tree ${bldylw} Count ${rec_count}  "
        git cat-file -p ${rec} #|awk '{print $4}' 
        tree-rec "${rec}"
        rec_count=0
        echo "${txtwht} white  exit"
    fi
    
done
}


declare -a list_index
find .git/objects/pack/ -name "*.idx" | while read i 
        do 
            list_index+=( $(git show-index < "$i" | awk '{print $2}') )
            #echo ${list_index[@]}
            
            # Print types 
            #for i in $(( ${#list_index[@]} ))
            for (( i=0; i < ${#list_index[@]}; i++ ))
                do
                    # git cat-file -t
                    echo " ${i}:  ${list_index[i]} `git cat-file -t ${list_index[i]}` "
                done
            #echo "${list_index[]}"
            
            # // print out data  
            for (( i=0; i < ${#list_index[@]}; i++ ))
                do
                    echo "${txtylw}"
                    case $( git cat-file -t ${list_index[i]} ) in 
                        tree)
                            echo " index No $i is a  Tree and it has " 
                            #echo " `git cat-file -p ${list_index[i]}` "
                            tree-rec "${list_index[i]}"
                            ;;

                        blob)
                            echo " index No $i is a Blob"
                            #git cat-file blob  ${list_index[i]}
                        
                        ;;
                        commit)
                            echo " index No $i is a Commit"
                            #git cat-file -p  ${list_index[i]}
                        ;;
                        tag)
                            echo " index No $i is a Tag"
                            #git cat-file -p  ${list_index[i]}
                        ;;
                    esac
                done
        done
