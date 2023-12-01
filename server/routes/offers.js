const express = require("express");
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth");
const FourImagesOffer = require("../model/four_images_offer");
const offersRouter = express.Router();


offersRouter.post("/admin/add-four-images-offer" , admin, async (req, res) => {

    try {
    const { title, images, labels, category } = req.body;        

    let fourImagesOffer = new FourImagesOffer({ title, images, labels, category });

    fourImagesOffer  = await fourImagesOffer.save();

    res.json(fourImagesOffer);

    } catch (err) {
        res.status(500).json({error: err.message});
    }

});


offersRouter.get("/api/get-four-images-offer" , auth , async (req, res) => {

    try {
        
        const fourImagesOffer = await FourImagesOffer.find();

        res.json(fourImagesOffer);

    } catch (err) {
        res.status(500).json({error: err.message});
    }
});


offersRouter.get("/admin/delete-four-images-offer/:offerId" , admin, async (req, res) => {

    try {
        const {offerId} = req.params;

        await FourImagesOffer.findByIdAndDelete(offerId);

        const offers = await FourImagesOffer.find();

        res.json(offers);

    } catch (err) {
        res.status(500).json({error: err.message});
    }
});


















module.exports = offersRouter;