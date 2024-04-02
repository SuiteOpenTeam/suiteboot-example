conn = new Mongo();
db = conn.getDB("suiteboot-example");
db.student.insert( { name:'jack', age:29 }  );
