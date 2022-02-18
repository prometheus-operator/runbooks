#!/usr/bin/env bash
# check urls via trying to connect to hugo server on localhost:1313

rm -rf kps
git clone --depth 1 https://github.com/prometheus-community/helm-charts/ kps

URL_PATHS=$(grep -R "runbook_url:" kps/charts/kube-prometheus-stack | grep .yaml | awk '{print $5}' | tr -d "}" | sort | uniq)

ENDPOINT=${ENDPOINT:-"http://localhost:1313/runbooks"}

exit_code=0
echo "Checking urls... please wait"

for runbook in $URL_PATHS; do
  if ! curl --output /dev/null --silent --head --fail "${ENDPOINT}${runbook}"; then
    rule_file=$(grep -n -R "$runbook" kps/charts/kube-prometheus-stack | awk '{print $1}')
    echo -e "Missing ${runbook} \n\t $EDITOR $rule_file"
    exit_code=1
  fi
done

if [ $exit_code == 0 ]; then
  echo "Great Success, no issues found!"
else
  echo "Oh no, errors!"
fi
exit $exit_code
