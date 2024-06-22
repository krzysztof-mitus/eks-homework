REPOSITORY=krzysztof-homework-app

aws ecr list-images --repository-name $REPOSITORY | jq -r '.imageIds[] | @base64' | while read image; do
    imageId=$(echo $image | base64 --decode | jq -r '.imageDigest')
    aws ecr batch-delete-image --repository-name $REPOSITORY --image-ids imageDigest=$imageId
done
