const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../model/product");
const User = require("../model/user");
const Order = require("../model/order");


userRouter.post("/api/add-to-cart", auth , async (req, res) => {
try {
    
    const {id} = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if(user.cart.length == 0){
        user.cart.push({product , quantity: 1});
    } else { 
        let isProductFound = false;
        for(let i = 0; i<user.cart.length; i++){
            if(user.cart[i].product._id.equals(product._id)){
                isProductFound = true;
            }
        }

        if(isProductFound){
            let cartProduct = user.cart.find((findProduct) => findProduct.product._id.equals(product._id));
            cartProduct.quantity += 1;
        } else {
            user.cart.push({product, quantity : 1});
        }
    }
    user = await user.save();
    res.json(user);

} catch (e) {
    res.status(500).json({error : e.message});
    
    }
});

userRouter.delete("/api/remove-from-cart/:id", auth , async (req, res)=> {
    try {

        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for(let i = 0 ; i < user.cart.length ; i++){
            if(user.cart[i].product._id.equals(product._id)){
               if(user.cart[i].quantity == 1){
                    user.cart.splice(i, 1);
               } else {
                user.cart[i].quantity -= 1;
               }
            }
        }

        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({error : e.message});
    }
})


userRouter.delete("/api/delete-from-cart/:id", auth, async (req, res)=>{
    try {

        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for(let i=0; i<user.cart.length; i++){
            if(user.cart[i].product._id.equals(product._id)){
                user.cart.splice(i,1);
                
            }
        }

        user = await user.save();
        res.json(user);


    } catch (e) {
        res.status(500).json({error : e.message});
    }
})


userRouter.post("/api/save-user-address" , auth , async (req, res) => {
    try {
        const {address} = req.body;
        let user = await User.findById(req.user);
    
        user.address = address;
        // user = await user.update({address: address});
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


userRouter.post("/api/order" , auth , async (req, res ) => {
    try {
        const { cart , totalPrice , address } = req.body;
    let products  = [];

    for(let i=0; i< cart.length; i++){
        let product = await Product.findById(cart[i].product._id);
        if(product.quantity >= cart[i].quantity){
            product.quantity -= cart[i].quantity;
            products.push({product, quantity : cart[i].quantity});
            await product.save();
        } else {
            return res.status(400).json({msg : `${product.name} is out of stock!`});
        }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
        products, 
        totalPrice,
        address,
        userId : req.user,
        orderedAt : new Date().getTime(),
    });

    order = await order.save();
    res.json(order);
    } catch (e) {
        res.status(500).json({error : e.message});
    }


});


userRouter.post("/api/place-order-buy-now", auth , async (req, res) => {

    try {
        
        const {id , totalPrice,  address} = req.body;
        const product = await Product.findById(id);

        let products = [];
        products.push({product, quantity : 1});

        let order = new Order({
            products,
            totalPrice,
            address,
            userId : req.user,
            orderedAt : new Date().getTime(),
        });

        order = await order.save();

        res.json(order);


    } catch (e) {
        res.status(500).json({error : e.message});
    }
}) ;


userRouter.get("/api/orders/me", auth , async (req, res ) => {

    try {
    const orders = await Order.find({ userId : req.user});
    res.json(orders);

    } catch (e) {
        res.status(500).json({error: `${e.message} from server`});
    }

});


userRouter.get("/api/orders/search/:name", auth, async (req, res) => {
    try {

        const orders = await Order.find({
            'products.product.name': {$regex: req.params.name, $options : "i"},
            userId : req.user,
        });

        res.json(orders);

    } catch (e) {
        res.status(500).json({error : e.message});
    }
})





userRouter.post("/api/save-for-later", auth , async(req, res) => {
    try{

        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);


        if(user.saveForLater.length == 0){
            user.saveForLater = [];
        }

        await user.saveForLater.push({product : product});


        for(let i=0; i< user.cart.length; i++){
            if(user.cart[i].product._id.equals(product._id)){
                user.cart.splice(i,1);
            }
        }
  

        user = await user.save();

        res.json(user);


    }catch(e){
        res.status(500).json({error: `${e.message} from server`});
    }
})


userRouter.delete("/api/delete-from-later/:id", auth, async (req, res) => {
    try {
        
        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for(let i=0; i<user.saveForLater.length; i++){
            if(user.saveForLater[i].product._id.equals(product._id)){
                user.saveForLater.splice(i,1);
            }
        }

        user = await user.save();

        res.json(user);




    } catch (e) {

        res.status(500).json({error : `${e.message} from server`});
        
    }
})


userRouter.post("/api/move-to-cart", auth , async (req, res) => {
    try {
        const {id} = req.body;
        const product  = await Product.findById(id);
        let user = await User.findById(req.user);


        for(let i = 0; i<user.saveForLater.length; i++){
            if(user.saveForLater[i].product._id.equals(product._id)){
                user.saveForLater.splice(i,1);
            }
        }

        if(user.cart.length == 0){
            user.cart.push({product , quantity: 1});
        } else { 
            let isProductFound = false;
            for(let i = 0; i<user.cart.length; i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
                }
            }
    
            if(isProductFound){
                let cartProduct = user.cart.find((findProduct) => findProduct.product._id.equals(product._id));
                cartProduct.quantity += 1;
            } else {
                user.cart.push({product, quantity : 1});
            }
        }
        user = await user.save();
        res.json(user);



    } catch (e) {
        res.status(500).json({error: `${e.message} from server`});
    }
});


userRouter.post("/api/keep-shopping-for", auth , async (req, res) => {

    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.keepShoppingFor.length == 0){
            user.keepShoppingFor.push({product});
        } else { 

            let productExist = false;

            for(let i=0; i<user.keepShoppingFor.length; i++){
                if(user.keepShoppingFor[i].product._id.equals(product._id)){
                    productExist = true;
                    break;
                }
            } 


            if(!productExist){
                user.keepShoppingFor.push({product});
            }
        }

        user = await user.save();
        res.json(user);
        
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


userRouter.post("/api/add-to-wish-list", auth, async (req, res ) =>{

    try {
        
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.wishList.length == 0){
            user.wishList.push({product});
        } else {

            let isFound = false;

            for(let i=0; i<user.wishList.length; i++){
                if(user.wishList[i].product._id.equals(product._id)){
                    isFound = true;
                    break;
                }
            }
            if(!isFound){
                user.wishList.push({product});
            }
        }

        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({error: e.message});
    }
});


userRouter.delete("/api/delete-from-wish-list/:id", auth, async (req, res) => {
    try {
        
        const {id} = req.params;
        const product = await  Product.findById(id);
        let user = await User.findById(req.user);

        for(let i=0; i<user.wishList.length ; i++){
            if(user.wishList[i].product._id.equals(product._id)){
                user.wishList.splice(i,1);
            }
        }

        user = await user.save();
        res.json(user);


    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


userRouter.post("/api/add-to-cart-from-wish-list", auth, async (req, res) => {

    try {

        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);


        for(let i = 0; i<user.wishList.length; i++){
            if(user.wishList[i].product._id.equals(product._id)){
                user.wishList.splice(i,1);
            }
        }

        if(user.cart.length == 0){
            user.cart.push({product , quantity: 1});
        } else { 
            let isProductFound = false;
            for(let i = 0; i<user.cart.length; i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
                }
            }
    
            if(isProductFound){
                let cartProduct = user.cart.find((findProduct) => findProduct.product._id.equals(product._id));
                cartProduct.quantity += 1;
            } else {
                user.cart.push({product, quantity : 1});
            }
        }


        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({error : e.message});
    }



});






module.exports = userRouter;