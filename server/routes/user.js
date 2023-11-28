const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../model/product");
const User = require("../model/user");
const Order = require("../model/order");




userRouter.get("/api/get-cart" , auth , async (req, res) => {

    try {
        
        let user = await User.findById(req.user);

        res.json(user.cart);
    } catch (e) {
        res.status(500).json({error : e.message});
    }


});



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
    res.json(user.cart);

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
        res.json(user.cart);

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
        res.json(user.cart);


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
        const { totalPrice , address } = req.body;
        let user = await User.findById(req.user);
        const userCart = user.cart;
    let products  = [];

    for(let i=0; i< userCart.length; i++){
        let product = await Product.findById(userCart[i].product._id);
        if(product.quantity >= userCart[i].quantity){
            product.quantity -= userCart[i].quantity;
            products.push({product, quantity : userCart[i].quantity});
            await product.save();
        } else {
            return res.status(400).json({error : `${product.name} is out of stock!`});
        }
    }

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
        console.log(e);
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

userRouter.get("/api/get-save-for-later", auth, async (req, res) => {

    try {
        const user = await User.findById(req.user);
        const saveForLaterList = await user.saveForLater;
        res.json(saveForLaterList);
    } catch (e) {
        res.status(500).json({error: e.message});
    }



});



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


userRouter.get("/api/add-keep-shopping-for/:id", auth , async (req, res) => {

    try {
        const {id} = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.keepShoppingFor.length == 0){
            user.keepShoppingFor.push({product});
        } else { 

            // let productExist = false;

            for(let i=0; i<user.keepShoppingFor.length; i++){
                if(user.keepShoppingFor[i].product._id.equals(product._id)){
                    user.keepShoppingFor.splice(i,1);
                    // productExist = true;
                    // break;
                }
            } 

            user.keepShoppingFor.push({product});


            // if(!productExist){
            //     user.keepShoppingFor.push({product});
            // }
        }

        user = await user.save();
        const keepShoppingFor = user.keepShoppingFor;
        res.json(keepShoppingFor);
        
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


userRouter.get("/api/get-keep-shopping-for", auth , async (req, res) => {

    try {
        let user = await User.findById(req.user);
        let productList = [];

        for(let i = 0; i<user.keepShoppingFor.length ; i++){
            productList.push(user.keepShoppingFor[i]['product']);

        }

        res.json(productList);
        
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


userRouter.get("/api/get-wish-list", auth, async (req, res ) =>{

    try {
        let wishList = [];
        let user = await User.findById(req.user);

        for(let i=0; i<user.wishList.length; i++){
            wishList.push(user.wishList[i]['product']);
        }

        

        res.json(wishList);

    } catch (e) {
        res.status(500).json({error: e.message});
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



userRouter.get("/api/is-wishlisted/:id", auth, async (req, res) => {

try {
    
    const {id} = req.params;
    
    let user = await User.findById(req.user);
    const product = await Product.findById(id);
    let isFound = false;
    for(let i=0; i<user.wishList.length ; i++){
        if(user.wishList[i].product._id.equals(product._id)){
            isFound =  true;
        }
    }

    res.json(isFound);

} catch (e) {
    res.status(500).json({error : e.message});
}});



userRouter.post("/api/add-to-cart-from-wish-list", auth, async (req, res) => {

    try {

        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        let wishList = [];


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

        for(let i=0; i<user.wishList.length; i++){
            wishList.push(user.wishList[i]['product']);
        }



        res.json(wishList);

    } catch (e) {
        res.status(500).json({error : e.message});
    }



});






module.exports = userRouter;