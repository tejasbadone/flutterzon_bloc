const mongoose = require("mongoose");

const FourImagesOfferSchema = mongoose.Schema({
    
    title:{
        type : String,
        required : true
    },
    images : [{
        type: String,
        required : true
    }],
    labels : [{
        type: String,
        required : true
    }],
    category : {
        type:String,
        required : true
    }
});

const FourImagesOffer = mongoose.model("Four Images Offer", FourImagesOfferSchema);

module.exports = FourImagesOffer;