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
            httpContextDefault = new DefaultHttpContext()
            {
                //RequestServices = serviceProviderMock.Object,
            };

            modelState = new ModelStateDictionary();

            actionContext = new ActionContext(httpContextDefault, httpContextDefault.GetRouteData(), new PageActionDescriptor(), modelState);

            modelMetadataProvider = new EmptyModelMetadataProvider();
            viewData = new ViewDataDictionary(modelMetadataProvider, modelState);
            tempData = new TempDataDictionary(httpContextDefault, Mock.Of<ITempDataProvider>());

            pageContext = new PageContext(actionContext)
            {
                ViewData = viewData,
            };

            mockWebHostEnvironment = new Mock<IWebHostEnvironment>();
            mockWebHostEnvironment.Setup(m => m.EnvironmentName).Returns("Hosting:UnitTestEnvironment");
            mockWebHostEnvironment.Setup(m => m.WebRootPath).Returns("../../../../src/bin/Debug/net6.0/wwwroot");
            mockWebHostEnvironment.Setup(m => m.ContentRootPath).Returns("./data/");

            var MockLoggerDirect = Mock.Of<ILogger<IndexModel>>();
            JsonFileProductService productService;

            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            productsController = new ProductsController(productService)
            {
            };
        }

        #endregion TestSetup
        #region OnGet
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
        [Test]
        public void OnPatch_Valid_For_Products_Rating_Update_Should_Return_Ok()
        {
            IEnumerable<ProductModel> products = productsController.Get();
            
            foreach (ProductModel product in products)
            {
               
                // Arrange
                JsonFileProductService newProductService;
                int ratingsSize = 0;
                if(product.Ratings != null)
                {
                    ratingsSize = product.Ratings.Count();
                }
                ProductsController.RatingRequest ratingRequest = new ProductsController.RatingRequest();
                ratingRequest.Rating = 1;
                ratingRequest.ProductId = product.Id;

                // Act
                var status = productsController.Patch(ratingRequest).ToString();
                
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
        [Test]
        public void OnPatch_Invalid_For_Negative_Products_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();
            ProductModel product = products.First();

            int ratingsSize = 0;
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }
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
        [Test]
        public void OnPatch_Invalid_For_Greater_Than_5_Products_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();
            ProductModel product = products.First();

            int ratingsSize = 0;
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }
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
        [Test]
        public void OnPatch_Invalid_For_Null_Product_ID_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();
            ProductModel product = products.First();

            int ratingsSize = 0;
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }
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
        [Test]
        public void OnPatch_Invalid_For_Unknown_Product_ID_Rating_Update_Should_Return_Bad_Request()
        {
            // Arrange
            IEnumerable<ProductModel> products = productsController.Get();
            ProductModel product = products.First();

            int ratingsSize = 0;
            if (product.Ratings != null)
            {
                ratingsSize = product.Ratings.Count();
            }
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