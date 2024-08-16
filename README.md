# Flutterzon - Amazon Clone w/ Flutter

![Flutterzon](https://res.cloudinary.com/dthljz11q/image/upload/v1701778309/app%20screenshots/siolcwzafbcuqch3j1sm.png)

Flutterzon is dedicated to the creation of an Amazon clone app, functioning as a full-stack e-commerce application. The technology stack includes Flutter for the front end, Node.js for the backend, MongoDB for data storage, Bloc for efficient state management, and Cloudinary for seamless image and media management. The primary objective is to faithfully mirror the functionality and user experience found in the Amazon mobile app.

Flutterzon focuses on delivering a seamless and responsive user interface, ensuring a smooth and intuitive experience for users navigating the platform. It also has the Admin Panel, strategically integrated to enhance control and facilitate effective management. This additional component caters to administrative needs, providing ways for overseeing and optimizing various aspects of the application.

Flutterzon is a purpose-driven initiative, with the primary goal of creating an Amazon clone app that faithfully reproduces the renowned functionality and user experience of the Amazon mobile app.

## Tech Stack

- **Client Side**

  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter Badge"> <a><img alt='Flutter' src='https://img.shields.io/badge/BLOC-100000?style=for-the-badge&logo=Flutter&logoColor=white&labelColor=3448C5&color=3448C5'/></a>

- **Server Side**

  ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
  ![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB) ![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white)
  ![MongoDB](https://img.shields.io/badge/Cloudinary-3448C5.svg?style=for-the-badge&logo=Cloudinary&logoColor=white)

## Features

- **Auth & User Data**

  - **Email & Password Authentication:** Log in and manage user accounts with email and password credentials.

  - **Persisting Auth State and User Type Redirection:** Remain logged in and automatically land on the correct dashboard (user or admin) based on your user type, both when launching the app and while signing in.

  - **User Data Persistence with Hydrated Bloc:** Store user data persistently using Hydrated Bloc for seamless user experience.

* **Home Screen**

  - **Dynamic Home Screen Offer:** Multiple offers on the home screen, including a captivating carousel of static image banners, a curated horizontal list of deals which is also static, but the four dynamic images offers can be easily updated from the backend for a constantly refreshing experience.

* **Product Management:**

  - **Category-Wise Products:** Organize products by category for easy browsing and navigation.

  - **Product Search:** Search for products efficiently using a dedicated search feature.

  - **Product Details:** View comprehensive product details, including average rating, rating count, and product recommendations based on the product category.

  - **Product Rating System:** Rate only products you have ordered, either through product details or order details screens.

  - **Deal of the Day:** Discover the highest-rated product as the "Deal of the Day."

* **Account Features:**

  - **Order Product:** Place orders for products seamlessly.

  - **Order Details:** Check order details, including status, and receive product recommendations based on the ordered product category.

  - **Search Orders:** Easily search for specific orders.

  - **Browsing History:** Maintain a history of recently visited products for convenient access.

  - **Wishlists:** Create and manage wishlists to keep track of desired products.

- **Cart Management:**

  - **Cart List:** View and manage products added to the cart.

  - **Cart Actions:**

    - Swipe right: Delete item from cart.
    - Swipe left: Add item to Save for Later list.
    - View similar products for cart items.

  - **Save for Later List:** Manage products saved for later.

  - **Save for Later Actions:**

    - Swipe right: Delete item from Save for Later list.
    - Swipe left: Add item to cart.
    - Delete, compare, and move products between cart and save for later list.

  - **Product Recommendations:** Receive product recommendations based on user browsing history or random recommendations if no browsing history exists.

  - **Checkout Options:**

    - **Google Pay Checkout:** Checkout using Google Pay for a secure and convenient payment experience.

    - **Buy Now Checkout:** Order selected products immediately after payment using the "Buy Now" option.

- **Admin Panel:** Manage the e-commerce platform effectively with the comprehensive admin panel.

  - **Admin Panel Features:**

    - **Product Management:** View, add, and delete products category-wise.

    - **Earnings Analysis:** Track total earnings and category-based earnings using a visual graph.

    - **Four Image Offer Management:** View, add, and delete four image offers from the admin section.

    - **Order Management:** View order details and change order status.

- **Sign Out:** Easily sign out of both user and admin accounts.

- **Some of used packages:**

  - **bloc:** Leverages bloc for effective state management.

  - **hydrated_bloc:** Persists user data using hydrated_bloc for a seamless user experience.

  - **equatable:** Compares objects efficiently using equatable for enhanced performance.

  - **syncfusion_flutter_charts package:** Utilizes the syncfusion_flutter_charts package to display category-wise earnings in a comprehensive graph format.

  - **go_router:** Employs go_router for efficient page navigation throughout the application.

## Screenshots

- **Home**

  ![Product](https://res.cloudinary.com/dthljz11q/image/upload/v1701778309/app%20screenshots/siolcwzafbcuqch3j1sm.png)

- **Product**

  ![Product](https://res.cloudinary.com/dthljz11q/image/upload/v1701778280/app%20screenshots/us7ly8uw44psccxhydix.png)

- **Order**

  ![Order](https://res.cloudinary.com/dthljz11q/image/upload/v1701778275/app%20screenshots/scw9sbczjhwudvqv0qu4.png)

- **Cart**

  ![Cart](https://res.cloudinary.com/dthljz11q/image/upload/v1701778276/app%20screenshots/kxjwd0psvd6jmmhxcfdu.png)

- **Admin**

  ![Admin](https://res.cloudinary.com/dthljz11q/image/upload/v1701778280/app%20screenshots/hnz3sythaq4kd1jw2yjl.png)

  ![Admin](https://res.cloudinary.com/dthljz11q/image/upload/v1701778276/app%20screenshots/unkzi75wyhw7dq96nuis.png)

- **Video Link** - [https://drive.google.com/uc?id=1XwgXe3bwy-LK_AiMJoD60q6w9Lf8A_oj](https://drive.google.com/uc?id=1XwgXe3bwy-LK_AiMJoD60q6w9Lf8A_oj)

## Run Locally

- Clone this repository

  ```bash
  https://github.com/tejasbadone/flutterzon_bloc.git
  ```

- Migrate to the root directory and install all the required dependencies by running
  ```bash
  flutter pub get
  ```
- Create MongoDB Project & Cluster
- Connect to the cluster using Drivers and get the connection string.
- I've created a `config.env` file at the root directory of the project, containing the essential details for the setup, you could also create one or update the necessary values directly, it's totally up to you. demo of `config.env` file -
    ```
    PORT=PORTHERE
    DB_USERNAME='usernameHere'
    DB_PASSWORD='passwordHere'

    URI='uriHere'

    CLOUDINARY_CLOUDNAME='cloudname'
    CLOUDINARY_UPLOADPRESET='uploadpreset'
    ```

- Head to `server/index.js` and replace the userName, password, and connection string.
- Head to `lib/src/utils/constants/strings.dart` and replace the `uri` with your IP address.
- Create Cloudinary Project, and enable the unsigned operation in settings.
- Head to `lib/src/data/repositories/admin_repository.dart`, update the `cloudinaryCloudName` and `cloudinaryUploadPreset` present in the `uploadImages()` method.
- Now, run the following commands, to migrate to the server folder, install the necessary dependencies, and run the server locally.
  ```
  cd server
  npm install
  npm run dev (to run index.js using nodemon)
  OR
  npm start (to run index.js)
  ```
  Please star⭐ the repo if you like what you see😉.

## Download

Download apk - https://drive.google.com/file/d/1K1k8DbwHfyAnujwRAPgzXmcEUVABFB_p/view?usp=sharing

## Test Credentials

- User

  - Email: user@email.com
  - Password: 123456

- Admin
  - Email: admin@email.com
  - Password: 123456

## Note

- If you wish to place an order in the application, you can enroll in the [Google Pay API Test Cards Allowlist](https://groups.google.com/g/googlepay-test-mode-stub-data). This will provide you with mock card details, allowing you to safely test the order placement functionality within a controlled environment.

- For the GitHub version of Flutterzon apk provided above, please note that certain administrative features, such as the ability to delete products and offers, have been intentionally disabled to prevent unintended tampering with the actual database. The original codebase, accessible to you, includes the complete functionality, including the ability to delete products. If you wish to explore the full range of features, please refer to the original code provided.

- Please be aware that the application or APIs might experience delays in providing details, as the server is hosted on a hobby plan, If there is no activity for 15 minutes, the server may go to sleep, resulting in a delay in processing the first API request. Your patience during this process is greatly appreciated.

- If you are interested, there is another version of this project built using Provider and Flutter's `setState`. You can access it [here](https://github.com/tejasbadone/flutterzon_provider).

## Disclaimer

This application is a personal project built with educational and learning purposes in mind. It is neither affiliated nor endorsed by Amazon in any way. While the app features product details and images inspired by Amazon, these are solely for demonstration purposes and may not represent actual products. All rights to these elements belong to their respective owners. We are using them for educational purposes only and have no intention of commercial exploitation.

Additionally, be aware that any attempts to place orders within this prototype are purely for testing purposes and will not result in actual product deliveries or charges in the real-world. This environment is designated exclusively for simulation and development purposes

## Contact

- Tejas Badone <br> <br>
  <a  href="https://www.linkedin.com/in/tejasbadone/" target="_blank"><img alt="LinkedIn" src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" /></a>
  <a href="mailto:tejas.badone25@gmail.com"><img  alt="Gmail" src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" />

  feel free to contact me!

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/tejasbadone/flutterzon_bloc/blob/main/LICENSE) file for details
