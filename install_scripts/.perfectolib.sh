unamestr=`uname`
MD5="md5"
md5opts=''
[ "$unamestr" == "Linux" ] && { MD5="md5sum"; md5opts='--'; platform='linux'; }
[ "$unamestr" == 'Darwin' ] && { platform='darwin'; }
[ "$unamestr" == 'FreeBSD' ] && { platform='freebsd'; }

CRE='\033[0;31m'
CGR='\033[0;32m'
CBGR='\033[1;32m'
CYE='\033[0;33m'
CUPUR='\033[4;35m'
CICYA='\033[0;96m'
CBIWH='\033[1;97m'
CIBL='\033[0;94m'
NC='\033[0m'

# read_char var
read_char() {
  oldSttySettings=`stty -g`
  stty -echo raw
  eval "$1=\$(dd bs=1 count=1 2>/dev/null)"
  stty "$oldSttySettings">/dev/null
}

Yn(){
  printf "$2 [${CGR}Y${NC}/n]: "
  local  __resultvar=$1
  while IFS= read_char char
  do
    [ "$char" == "n" ] || [ "$char" == "N" ] && { printf "${CRE}n${NC}\n"; myresulto='n'; break; }
    [ "`printf '%d' "'$char"`" == "13" ] || [ "$char" == "y" ] || [ "$char" = "Y" ] && { printf "${CGR}y${NC}\n"; myresulto='y' ; break; }
  done
  local  myresult=`echo "$myresulto"`
  eval $__resultvar="'$myresult'"
}

yN(){
  printf "$2 [y/${CRE}N${NC}]: "
  local  __resultvar=$1
  while IFS= read_char char
  do
    [ "`printf '%d' "'$char"`" == "13" ] || [ "$char" == "n" ] || [ "$char" == "N" ] && { printf "${CRE}n${NC}\n"; myresulto='n'; break; }
    [ "$char" == "y" ] || [ "$char" = "Y" ] && { printf "${CGR}y${NC}\n"; myresulto='y' ; break; }
  done
  local  myresult=`echo "$myresulto"`
  eval $__resultvar="'$myresult'"
}

read_email(){
  local  __resultvar=$1
  while read -p "$2: " addr
  do
    case $addr in
      *@?*.?*) break ;;
      *) echo "incorrect email" ;;
    esac
  done
  local  myresult=`echo "$addr"`
  eval $__resultvar="'$myresult'"
}

read_num() {
  local  __resultvar=$1
  while read -p "$2: " mynum
  do
    case $mynum in
      ''|*[!0-9]*) echo "Enter number please" ;;
      *) break ;;
    esac
  done  
  local  myresult=`echo "$mynum"`
  eval $__resultvar="'$myresult'"
}

yaget(){
	dlink=`curl -s "https://cloud-api.yandex.net:443/v1/disk/public/resources/download?public_key=$1" | \
			sed -e 's/^.*"href":"\([^"]*\)".*$/\1/' | grep "https://"`
	[ -n "$dlink" ] && { 
	printf "\n[${CGR}got direct link${NC}]\n"
		wget -O $2 -c -t9 $dlink -q --show-progress 

	} || printf "\n[${CRE}get direct link error${NC}]\n"
}

saveto()
{
	[ -e $2 ] && {
	  Yn ans "$2 already exists, remove and download now?"
	  [ "$ans" ==  "y" ] && rm -f $2
	}
	yaget "$1" "$2"
}

set_global()
{
  file="/srv/work/globals/$2"
  [ -e $file ] && {
    yN ans "$file already exists [`cat $file`], set new value?"
    [ "$ans" == "n" ] && return
  }
  printf "${CGR}$1${NC}: "
  read text
  echo "set '$text' to $file"
  echo "$text" > $file
}
