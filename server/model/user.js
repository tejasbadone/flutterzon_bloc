const mongoose = require("mongoose");
const {productSchema} = require("./product");

const userSchema = mongoose.Schema({
    name:{
        require: true,
        type: String,
        trim: true,
    },
    email : {
        require: true,
        type: String,
        trim: true,
        validate : {
            validator : (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message : 'Please enter a valid email address',
        }
    },
    password : {
        require : true,
        type : String,
        validate : {
            validator : (value) => {
                if(value.length < 6){
                    return 'Password must have at least 6 characters';
                }
            },
        }

    },
    address : {
        type : String,
        default : '',
    },
    type : {
        type: String,
        default : 'user',
    },
    cart : [{

        product : productSchema,
        quantity : {
            type: Number,
            required : true,
        }


    }],
    saveForLater : [{

        product : productSchema,
    }],

    keepShoppingFor : [{
        product : productSchema,
    }],
    wishList : [{
        product : productSchema,
    }]

})

const User = mongoose.model("User", userSchema);

module.exports = User;




