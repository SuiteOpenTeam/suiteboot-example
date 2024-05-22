until mongosh --host mongodb --eval "print(\"waited for connection\")"
do
    sleep 1
done

echo "init Replica-Set..."
mongosh --host mongodb --eval " rs.initiate( {_id: \"myReplicaSet\", members: [  {_id: 0, host: \"mongodb:27017\"}] }) "
mongosh --host mongodb --eval " rs.status()  "
mongorestore --host mongodb --db=suiteboot-example --drop /mongodb/data

