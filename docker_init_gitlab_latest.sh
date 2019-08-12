# !/bin/bash

container_name=$1;
volume_dir=$2;

if [ ! $container_name ] || [ ! $volume_dir ]; then
    echo 'Usage ./docker_init_gitlab.sh \${container_name} \${docker_volume_dir}';
    exit -1;
fi

echo 'Drop if there is already exist an instance ...'
sudo docker container stop $container_name;
sudo docker container rm $container_name;
echo "Docker Volumes: $docker_volumes, starting initializing...";
sudo docker run --name $container_name -p 443:443 -p 80:80 --restart always -v $volume_dir/config:/etc/gitlab -v $volume_dir/logs:/var/log/gitlab -v $volume_dir/data:/var/opt/gitlab -d gitlab/gitlab-ce;