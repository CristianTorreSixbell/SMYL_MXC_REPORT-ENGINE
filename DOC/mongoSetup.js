import { chargeData} from '../lib/dotenvExtractor.js';

chargeData();
const dbName = process.argv[5];
const adminDbName = "admin";
const user = "@$MtNY@";
const pass = "b3^94O,g3hhy";

db = db.getSiblingDB(dbName);
db.createUser({
  user: user,
  pwd: pass,
  roles: [{ role: "dbOwner", db: dbName }]
});

db = db.getSiblingDB(adminDbName);
db.createUser({
  user: user,
  pwd: pass,
  roles: [{ role: "dbOwner", db: adminDbName }]
});