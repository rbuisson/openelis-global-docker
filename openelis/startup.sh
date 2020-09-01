#!/bin/bash -eux
DEBUG=${DEBUG:-false}
DEBUG_PORT=${DEBUG_PORT:-8000}
catalina_params=()

# for file in /etc/properties/*; do
# name=$(basename "${file}")
# envsubst < ${file} > /usr/local/tomcat/.OpenMRS/${name}
# done

if [ $DEBUG == true ]; then
    export JPDA_ADDRESS=$DEBUG_PORT
    export JPDA_TRANSPORT=dt_socket
    catalina_params+=(jpda)
fi

openelis_params=()
openelis_params+="-Ddatasource.url=jdbc:postgresql://database:5432/clinlims"
openelis_params+="-Ddatasource.username=clinlims -Ddatasource.password=password"

catalina_params+=(start)

# start tomcat
/usr/local/tomcat/bin/catalina.sh "${catalina_params[@]}" "${openelis_params[@]}"
