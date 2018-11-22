#!/bin/bash

set -e

if [ -z "${IMPORT_GITHUB_PUB_KEYS+xxx}" ] || [ -z "${IMPORT_GITHUB_PUB_KEYS}" ]; then
	echo "WARNING: env variable \$IMPORT_GITHUB_PUB_KEYS is not set. Please set it to have access to this container via SSH."
else
	# Read passed to container ENV IMPORT_GITHUB_PUB_KEYS variable with coma-separated
	# user list and add public key(s) for these users to authorized_keys on 'www-data' account.
	for user in $(echo $IMPORT_GITHUB_PUB_KEYS | tr "," "\n"); do
		echo "processing github user: $user"
		su www-data -c "github-keys.sh $user"
	done
fi

if [ "${AWS_ACCESS_KEY_ID}" ]; then
	aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
	aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
	aws configure set default.region ${AWS_DEFAULT_REGION}
	echo "AWS cli configured for access key ${AWS_ACCESS_KEY_ID}"
fi
