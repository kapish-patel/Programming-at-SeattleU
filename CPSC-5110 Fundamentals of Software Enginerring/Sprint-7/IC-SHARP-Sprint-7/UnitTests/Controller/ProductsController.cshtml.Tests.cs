using System.Linq;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Routing;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;

using Moq;

using NUnit.Framework;

using ContosoCrafts.WebSite.Pages.Product;
using ContosoCrafts.WebSite.Services;
using ContosoCrafts.WebSite.Controllers;
using ContosoCrafts.WebSite.Models;
using System.Collections.Generic;
using System;

namespace UnitTests.Controller
{
    /// <summary>
    /// A class for representing product control unit tests
    /// </summary>
    public class ProductsControllerTests
    {
        #region TestSetup
        public static IUrlHelperFactory urlHelperFactory;
        public static DefaultHttpContext httpContextDefault;
        public static IWebHostEnvironment webHostEnvironment;
        public static ModelStateDictionary modelState;
        public static ActionContext actionContext;
        public static EmptyModelMetadataProvider modelMetadataProvider;
        public static ViewDataDictionary viewData;
        public static TempDataDictionary tempData;
        public static PageContext pageContext;

        public static ProductsController productsController;
        Mock<IWebHostEnvironment> mockWebHostEnvironment;

        [SetUp]
        public void TestInitialize()
        {
            //Creates a new object for http context
            httpContextDefault = new DefaultHttpContext()
            {
                //RequestServices = serviceProviderMock.Object,
            };

            //Creates a new object for model state
            modelState = new ModelStateDictionary();

            //Creates a new object for action context based on http context and model state
            actionContext = new ActionContext(httpContextDefault, httpContextDefault.GetRouteData(), new PageActionDescriptor(), modelState);

            //Creates a new object for metadata provider
            modelMetadataProvider = new EmptyModelMetadataProvider();

            //Creates a new object of View Data dictionary
            viewData = new ViewDataDictionary(modelMetadataProvider, modelState);

            //Creates a new object of Temp Data dictionary
            tempData = new TempDataDictionary(httpContextDefault, Mock.Of<ITempDataProvider>());

            //Creates a new object of page context using action context
            pageContext = new PageContext(actionContext)
            {
                ViewData = viewData,
            };

            //Creates a mock hot environment
            mockWebHostEnvironment = new Mock<IWebHostEnvironment>();
            mockWebHostEnvironment.Setup(m => m.EnvironmentName).Returns("Hosting:UnitTestEnvironment");
            mockWebHostEnvironment.Setup(m => m.WebRootPath).Returns("../../../../src/bin/Debug/net6.0/wwwroot");
            mockWebHostEnvironment.Setup(m => m.ContentRootPath).Returns("./data/");

            //Initializes a mock logger for the model
            var MockLoggerDirect = Mock.Of<ILogger<IndexModel>>();

            //Creates product service object for JSON object file
            JsonFileProductService productService;

            //Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a product conroller object for unit testing
            productsController = new ProductsController(productService)
            {
            };
        }

        #endregion TestSetup
        #region OnGet
        /// <summary>
        /// Unit test for OnGet method to check if controller return null when product is empty  
        /// </summary>
        [Test]
        public void OnGet_Valid_Should_Not_Return_Empty_Products()
        {
            // Arrange

            // Act
            IEnumerable<ProductModel> products =  productsController.Get();

            // Assert
            Assert.AreEqual(true, productsController.ModelState.IsValid);
            Assert.AreNotEqual(null, products);
        }
        #endregion OnGet

        #region OnPatch
        /// <summary>
        /// Unit test for OnPatch method to check if controller return Ok when valid product rating is updated  
        /// </summary>
        [Test]
        public void OnPatch_Valid_For_Products_Rating_Update_Should_Return_Ok()
        {
            IEnumerable<ProductModel> products = productsController.Get();
            
            foreach (ProductModel product in products)
            {
               
                // Arrange
                JsonFileProductService newProductService;

                //Initialize the rating size
                int ratingsSize = 0;

                //If ratings for that product exist then update the rating size
                if (product.Ratings != null)
                {
                    ratingsSize = product.Ratings.Count();
                }

                //Create a rating request object and initialize
                ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
                ratingRequest.Rating = 1;
                ratingRequest.ProductId = product.Id;

                // Act
                var status = productsController.Patch(ratingRequest).ToString();
                
                //Creates and new product service to get all data
                newProductService = new JsonFileProductService(mockWebHostEnvironment.Object);
                ProductModel newProduct = newProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(product.Id));
                int newRatingsSize = newProduct.Ratings.Count();

                // Reset
                productsController.ProductService.UpdateData(product);

                // Assert
                Assert.AreEqual(true, productsController.ModelState.IsValid);
                Assert.AreEqual(ratingsSize+1, newRatingsSize);
                Assert.AreEqual("Microsoft.AspNetCore.Mvc.OkResult", status);

            }
        }
        #endregion OnPatch

        #region OnPatch
        /// <summary>
        /// Unit test for OnPatch method to check if controller return Bad Request when product rating is updated with negative value 
        /// </summary>
        [Test]
        public void OnPatch_Invalid_For_Negative_Products_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();

            //Get the first product
            ProductModel product = products.First();


            //Initialize the rating size
            int ratingsSize = 0;

            //If ratings for that product exist then update the rating size
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }

            //Create a rating request object and initialize
            ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
            ratingRequest.Rating = -1;
            ratingRequest.ProductId = product.Id;

            // Act
            var status = productsController.Patch(ratingRequest).ToString();

            // Reset
            productsController.ProductService.UpdateData(product);

            // Assert
            Assert.AreEqual(true, productsController.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.BadRequestResult", status);

        }
        #endregion OnPatch

        #region OnPatch
        /// <summary>
        /// Unit test for OnPatch method to check if controller return Bad Request when product rating is above 5 
        /// </summary>
        [Test]
        public void OnPatch_Invalid_For_Greater_Than_5_Products_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();

            //Get the first product
            ProductModel product = products.First();


            //Initialize the rating size
            int ratingsSize = 0;

            //If ratings for that product exist then update the rating size
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }

            //Create a rating request object and initialize
            ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
            ratingRequest.Rating = 6;
            ratingRequest.ProductId = product.Id;

            // Act
            var status = productsController.Patch(ratingRequest).ToString();

            // Reset
            productsController.ProductService.UpdateData(product);

            // Assert
            Assert.AreEqual(true, productsController.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.BadRequestResult", status);

        }
        #endregion OnPatch

        #region OnPatch
        /// <summary>
        /// Unit test for OnPatch method to check if controller return Bad Request when product rating is null 
        /// </summary>
        [Test]
        public void OnPatch_Invalid_For_Null_Product_ID_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();

            //Get the first product
            ProductModel product = products.First();

            //Initialize the rating size
            int ratingsSize = 0;

            //If ratings for that product exist then update the rating size
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }

            //Create a rating request object and initialize
            ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
            ratingRequest.Rating = 2;
            ratingRequest.ProductId = null;

            // Act
            var status = productsController.Patch(ratingRequest).ToString();

            // Reset
            productsController.ProductService.UpdateData(product);

            // Assert
            Assert.AreEqual(true, productsController.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.BadRequestResult", status);

        }
        #endregion OnPatch

        #region OnPatch
        /// <summary>
        /// Unit test for OnPatch method to check if controller return Bad Request when product rating is updated for unknown product ID 
        /// </summary>
        [Test]
        public void OnPatch_Invalid_For_Unknown_Product_ID_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();

            //Get the first product
            ProductModel product = products.First();

            //Initialize the rating size
            int ratingsSize = 0;

            //If ratings for that product exist then update the rating size
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }
            //Create a rating request object and initialize
            ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
            ratingRequest.Rating = 3;
            ratingRequest.ProductId = "aaa";

            // Act
            var status = productsController.Patch(ratingRequest).ToString();

            // Reset
            productsController.ProductService.UpdateData(product);

            // Assert
            Assert.AreEqual(true, productsController.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.BadRequestResult", status);

        }
        #endregion OnPatch

    }
}