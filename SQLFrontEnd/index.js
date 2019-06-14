const bodyParser = require('body-parser');
const exphbs = require('express-handlebars');
const express = require('express');
const SQL = require('./libs/sql');

const app = express();


app.engine('.hbs', exphbs({
    defaultLayout: 'layout',
    extname: '.hbs'
}));

app.set('view engine', '.hbs');

app.use(express.static(__dirname + '/views'));

app.use(bodyParser.urlencoded({
    extended: false
}));

app.use(bodyParser.json());

//when browser sends get request
app.get('/', (req, res) => {
    res.render('index');
});



/* Insert code here*/
let connectOptions = [
    'localhost',
    'root',
    'doggy101',
    'test_schema'
]

let sql = new SQL(...connectOptions);



app.post('/insert',(req,res) => {

    let name = req.body.name;
    let email = req.body.email;
    let telephone = req.body.phoneNo;
    let password = req.body.password;

    sql.insert(name, email, telephone, password);
    res.render('index');
})

app.listen(1337, () => {
    console.log("listening on port 1337")
})