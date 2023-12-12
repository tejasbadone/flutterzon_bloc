const express = require("express");
const User = require("../model/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();




// Sign Up Route
authRouter.post("/api/signup", async (req, res) => {
    try {

        let {name, email, password} = req.body;

        email = email.toLowerCase();

        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({msg: "User with same email already exists"});
        }

        if(password.length < 6){
            return res.status(400).json({msg : "Password must have at least 6 characters"});
        }

        const hashedPassword = await bcrypt.hash(password, 8);

        let user = User({
            email, password : hashedPassword, name,
        })

        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({msg : `${e.message}`});
    }

})


// Sign in Route
authRouter.post('/api/signin', async (req, res ) => {
    try {
        let {email, password} = req.body;

        email = email.toLowerCase();

        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg : "User does not exist!"});
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg : "Incorrect password!"})
        }
        
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});



    } catch (e) {
        res.status(500).json({msg: e.message});
    }
})

authRouter.get('/IsTokenValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');


        if(token == '') return res.json(false);
        if(!token) return res.json(false);
        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified) return res.json(false);

        const user = await User.findById(isVerified.id);
        if(!user) return res.json(false);

        res.json(true);

    } catch (e) {
        res.status(500).json({msg : e.message})    
    }
})


authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})


module.exports = authRouter;
