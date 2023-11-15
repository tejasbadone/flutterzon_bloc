const express = require("express");
const path = require("path");
const mongoose = require("mongoose");
require("dotenv").config({path : path.join(__dirname, '..' , 'config.env')});


const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const app = express();
const PORT = process.env.PORT;
const userName = process.env.DB_USERNAME;
const password = encodeURIComponent(process.env.DB_PASSWORD);
const DB = `mongodb+srv://${userName}:${password}@cluster0.fkliyeh.mongodb.net/flutterzon?retryWrites=true&w=majority`


// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(DB).then(()=>{
    console.log('Mongoose Connected!');
}).catch((e)=>{
    console.log(e);
})


app.get("/" , (req, res) => {
    res.send('amazon_flutter_clone_bloc!');
});


app.listen(PORT, "0.0.0.0",() => {
    console.log(`Connected at PORT : ${PORT}`)
})