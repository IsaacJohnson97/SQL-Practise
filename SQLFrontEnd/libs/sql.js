
const mysql = require('mysql');


// This creates a connection when we create our instace
class SQL {
    constructor(host, user, password, database){
        this.connection = mysql.createConnection({
            host: host,
            user: user,
            password: password,
            database: database
        });
    }
    insert(name, email, telephone, password){
        this.connection.query(`INSERT INTO user SELECT '${name}','${email}','${telephone}', '${password}';`, (error,results) => {
            if (error) throw error;
        });
    }
}


module.exports = SQL