#!/bin/bash

# bash-httpd, by Morty Abzug <morty@sanctuary.arbutus.md.us>
# v0.05: slaytor: 2017/06/26: simple cgi-bin for .sh
# v0.04: slaytor: 2016/10/08: virtual hosting (DOC_ROOT/domain.name/)
# v0.03: slaytor: 2016/08/12: some mime types, urldecode, -k option for nc, remove ~user explore
# v0.02: morty: 1998/11/22: does simple file queries
# v0.01: morty: 1998/11/??: proof of concept

# HOW TO USE:
# assuming this script saved as "webserver.sh", run it with:
# (while true; do nc -l -k -p 80 -e webserver.sh; done)&
# socat TCP4-LISTEN:80,fork EXEC:./webserver.sh
# Configurable variables
PATH=/bin:/usr/bin
DOC_ROOT=`pwd`
DEF_HTML=index.html
LOG_FACILITY=local1
# End of configurables

HTTP_VERSION="HTTP/1.0"
SERVER="bash-httpd/0.05"

CR=`printf "\015"`
program="${0##/*/}"

response_code(){
    num="$1"
    case "$num" in
	200) err="OK";;
	403) err="Forbidden";;
	404) err="Not Found";;
	500) err="Internal Server Error";;
	501) err="Not Implemented";;
	*)   err="Internal Server Error"
	    log err "Unknown response: $num"
	    num=500
	    ;;
    esac
    log notice "response: $num"
    echo "$HTTP_VERSION $num $err"
}

error(){
    response_code $1
    if [ "$2" ]; then problem="$2"; else problem="$err"; fi
cat <<EOF
Content-Type: text/html

<html> <head> <title> $problem </title> 
<body> <h1> $num $problem </h1> $problem </body> </html>
EOF
    log err "$problem"
    exit 1
}

log(){
    level="$1"; message="$2"
    logger -p $LOG_FACILITY."$level" "$program[$$]: $method $url $version: $message"
}

urldecode() {
  arg="$1"
  i="0"
  while [ "$i" -lt ${#arg} ]
  do
    c0=${arg:$i:1}
    if [ "x$c0" = "x%" ]
    then
      c1=${arg:$((i+1)):1}
      c2=${arg:$((i+2)):1}
      printf "\x$c1$c2"
      i=$((i+3))
    else
      echo -n "$c0"
      i=$((i+1))
    fi
  done
}
read method url version
read mytosttag vhostname
method="${method%$CR}";
url="${url%$CR}";
version="${version%$CR}";
VHOSTNAME=`echo "${vhostname%$CR}" | sed -e "s/\([^:/]*\).*/\1/"`
[ ! -d $DOC_ROOT/$VHOSTNAME ] && VHOSTNAME="default"
case "$version" in
    ""|http/0.9|HTTP/0.9) 
	readmore=0;;
    http/1.0|HTTP/1.0|http/1.1|HTTP/1.1)
	readmore=1;;
    *)
	log notice "$method $url $version"
	error 501 "Unknown version";;
esac

if [ "$readmore" != 0 ]; then
    read foo; while [ "$foo" != "$CR" -a "$foo" != "" ]; do read foo; done
fi

case "$method" in
    GET|get) 
	what=get;;
    HEAD|head) 
	what=head;;
    *)
	error 501 "Unimplemented method";;
esac

sep='?'
case $url in
  (*"$sep"*)
    before=${url%%"$sep"*}
    after=${url#*"$sep"}
    ;;
  (*)
    before=$url
    after=
    ;;
esac
url="$before"
GET_PARAMS="$after"
#echo $(urldecode $GET_PARAMS);exit 0;
case "$url" in
    */../*|*[^/\%A-Za-z0-9_.-]*) 
	error 403 "Illegal attempt to access resource"
	;;
    ""|/*)
	type=file; file="$DOC_ROOT/$VHOSTNAME/$(urldecode $url)"
	;;
    *) 
	error 501 "Unknown request type"
	;;
esac

case $type in 
    file)
	if [   -d "$file" ]; then file="$file/$DEF_HTML"; fi
	if [ ! -e "$file" ]; then error 404; fi
	if [ ! -r "$file" ]; then error 403; fi
	response_code 200
	if [ "$what" = "head" ]; then echo; exit 0; fi
	case "$file" in
	    *.sh)
			mime="text/html; charset=utf-8"
			echo Content-Type: $mime; echo;
			(cd $DOC_ROOT/$VHOSTNAME && echo "`$file $GET_PARAMS`")
			exit 0;
		;;
	    *.html | *.htm) mime="text/html; charset=utf-8";;
	    *.css) 		mime="text/css;  charset=utf-8";;
	    *.jpg|*.jpeg)	mime=image/jpeg;;
	    *.png) 		mime=image/png;;
	    *.gif) 		mime=image/gif;;
	    *.gz|*.tgz)		mime=application/binary;;
	    *.zip)		mime=application/binary;;
	    *.txt|*.text)	mime="text/plain; charset=utf-8";;
	    *)			mime=`file -ib $file`;;
	esac
	echo Content-Type: $mime; echo; cat $file
	;;
    *)
	error 501 "Messed up internal type"
	;;
esac
