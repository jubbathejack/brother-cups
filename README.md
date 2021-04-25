# brother-cups
Docker image containing CUPS server and Brother drivers (WIP).

Some portions based on ykdin/cups and monkeydri/cups-docker.

## Starting the container
The container can be started by running the following command:
```shell
docker run -d --restart=always -p 631 --net=host -e ADMIN_PASSWD=aGoodPassword -v /path/to/local/cups-folder:/etc/cups jubbathejack/brother-cups
```
