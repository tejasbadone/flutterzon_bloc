const jwt = require("jsonwebtoken");

const auth = async (req, res , next) => {
    try {
        const token = req.header('x-auth-token');
        if(!token) 
            return res.status(401).json({msg: "No auth token, access denied!"});

        const isverified = jwt.verify(token, "passwordKey");
        if(!isverified) 
            return res.status(401).json({msg: "Token verification failed, Authorization denied!"});
        
        req.user = isverified.id;
        req.token = token;

        next();

    } catch (err) {
        res.status(500).json({error : err.message});
    }
}

module.exports = auth;