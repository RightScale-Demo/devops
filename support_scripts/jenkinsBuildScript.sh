RS_ACCOUNT="ACCOUNT_ID_GOES_HERE"
RS_TOKEN="REFRESH_TOKEN_GOES_HERE"
RS_HOST="my.rightscale.com"
rsc_cmd="rsc -h ${RS_HOST} -a ${RS_ACCOUNT} -r ${RS_TOKEN}"

# TODO use rsc to find the script_href
right_script_href="/api/right_scripts/589829003"


${rsc_cmd} cm15 by_tag /api/tags/by_tag "resource_type=instances" "tags[]=devops:servertype=webserver" | \
jq '.[] | { links: .links[].href}' |  \
grep links | \
cut -d":" -f2 | sed 's/"//g' |
while read instance_href
do
        ${rsc_cmd} --dump=debug cm15 run_executable ${instance_href} "right_script_href=${right_script_href}" \
        "inputs[][name]=APPLICATION_REPO" \
        "inputs[][value]=text:$GIT_URL" # GIT_URL is an environment variable set by Jenkins server
done
