#!/bin/bash

HTML=`cat tpl/farm-list.tpl`
re='\{([0-9a-zA-Z\-]+)\}'
while [[ $HTML =~ $re ]]; do
  RESULT="`exec tpl/${BASH_REMATCH[1]}.sh`"
  HTML="${HTML//${BASH_REMATCH[0]}/${RESULT}}"
done
echo "$HTML"
