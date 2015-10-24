./inv/dev/ec2.py |jq '.["tag_Name_teamcity-server"]' | grep "[0-9]" | sed -e 's/"//g' -e 's/ //g'
