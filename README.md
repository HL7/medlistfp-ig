## Initial Setup
```
> docker run --name=medlistfp-ig -it -v "$(pwd)":/app node:latest /bin/bash
@> (once) apt update; apt install graphviz jekyll
@> (once) dpkg -i jdk-25_linux-x64_bin.deb
@> (once) npm install -g fsh-sushi
@> npm install
```

## Build IG
```
@> curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o input-cache/publisher.jar
@> java -jar input-cache/publisher.jar -ig ig.ini -tx n/a
```

