```
> docker run --name=medlistfp-ig -it -v "$(pwd)":/app node:latest /bin/bash
@> (once) apt update; apt install graphviz jekyll
@> (once) dpkg -i jdk-25_linux-x64_bin.deb
@> (once) npm install -g fsh-sushi
@> java -jar input-cache/publisher.jar -ig ig.ini -tx n/a
```
