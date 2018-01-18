html_build()
{
  $HTML=$1
  re='\{([0-9a-zA-Z\_]+)\}'
  while [[ $HTML =~ $re ]]; do
    var="\$${BASH_REMATCH[1]}"
   HTML="${HTML//${BASH_REMATCH[0]}/`eval "echo \"$var\""`}"
  done
  echo "$HTML"
}
