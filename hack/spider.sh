#!/sur/bin/env bash
#
# crawl over all urls
ENDPOINT=${ENDPOINT:-"http://localhost:1313/"}

echo "Checking all urls... please wait"
docker run --network=host --rm tennox/linkcheck http://localhost:1313
