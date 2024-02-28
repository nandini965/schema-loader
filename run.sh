git clone https://github.com/nandini965/${COMPONENT}
cd $COMPONENT

if [ "$SCHEMA_TYPE" == "mongo" ]; then
  DOCDB_ENDPOINT=$(aws ssm get-parameters  --names prod.docdb.db_endpoint --with-decryption | jq .Parameters[].Value | sed -e 's/"//g')
  DOCDB_USER=$(aws ssm get-parameters  --names prod.docdb.db_user --with-decryption | jq .Parameters[].Value | sed -e 's/"//g')
  DOCDB_PASS=$(aws ssm get-parameters  --names prod.docdb.db_pass --with-decryption | jq .Parameters[].Value | sed -e 's/"//g')
  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem rds-combined-ca-bundle.pem
  mongo --ssl --host ${DOCDB_ENDPOINT}:27017 --sslCAFile rds-combined-ca-bundle.pem --username ${DOCDB_USER} --password ${DOCDB_PASS} <schema/${COMPONENT}.js

fi

if [ "$SCHEMA_TYPE" == "mysql" ]; then
echo

fi