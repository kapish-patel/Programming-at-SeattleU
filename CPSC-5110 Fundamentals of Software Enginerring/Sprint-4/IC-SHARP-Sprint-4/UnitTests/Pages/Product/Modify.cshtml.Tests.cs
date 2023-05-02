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
using ContosoCrafts.WebSite.Models;
using System.Collections;

namespace UnitTests.Pages.Product.Modify
{   
 /// <summary>
/// To perform tests for update page
/// </summary>
    public class UpdateTests
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

        public static ModifyModel modifyModel;

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

            var mockWebHostEnvironment = new Mock<IWebHostEnvironment>();
            mockWebHostEnvironment.Setup(m => m.EnvironmentName).Returns("Hosting:UnitTestEnvironment");
            mockWebHostEnvironment.Setup(m => m.WebRootPath).Returns("../../../../src/bin/Debug/net6.0/wwwroot");
            mockWebHostEnvironment.Setup(m => m.ContentRootPath).Returns("./data/");

            var MockLoggerDirect = Mock.Of<ILogger<IndexModel>>();
            JsonFileProductService productService;

            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            modifyModel = new ModifyModel(productService)
            {
            };
        }

        //Function to perform a Deep Copy on the product
        public static void DeepCopyProduct(ref ProductModel copyProduct, ProductModel product)
        {

            copyProduct.Id = product.Id;
            copyProduct.Maker = product.Maker;
            copyProduct.Image = product.Image;
            copyProduct.Url = product.Url;
            copyProduct.Title = product.Title;
            copyProduct.Description = product.Description;
            copyProduct.Ratings = product.Ratings;
            copyProduct.ProductType = product.ProductType;
            copyProduct.Quantity = product.Quantity;
            copyProduct.Price = product.Price;
            copyProduct.CommentList = product.CommentList;

        }

        #endregion TestSetup
        #region OnGet
        [Test]
        public void OnGet_Invalid_Empty_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_Negative_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("-1");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_For_Non_Numeric_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("abc");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_For_Floating_Point_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("0.1");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_For_Alpha_Numeric_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("a1");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_For_Zero_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            modifyModel.OnGet("0");

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Invalid_For_Special_Char_Product_Id_Should_Return_Null()
        {
            // Arrange
            string productId = "^";
            // Act
            modifyModel.OnGet(productId);
            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual(null, modifyModel.Product);
        }
        #endregion OnGet

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Description_Update()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                string productId = product.Id;
                modifyModel.OnGet(productId);
                DeepCopyProduct(ref oldProduct, modifyModel.Product);

                modifyModel.Product.Description = "Updating Description for " + modifyModel.Product.Title;
                modifyModel.OnPost();

                modifyModel.OnGet(productId);
                DeepCopyProduct(ref newProduct, modifyModel.Product);

                // Assert
                Assert.AreEqual(true, modifyModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                modifyModel.Product.Description = oldProduct.Description;
                modifyModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Maker_Update()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                string productId = product.Id;
                modifyModel.OnGet(productId);
                DeepCopyProduct(ref oldProduct, modifyModel.Product);

                modifyModel.Product.Maker = "Updating maker for " + modifyModel.Product.Title;
                modifyModel.OnPost();

                modifyModel.OnGet(productId);
                DeepCopyProduct(ref newProduct, modifyModel.Product);

                // Assert
                Assert.AreEqual(true, modifyModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                modifyModel.Product.Maker = oldProduct.Maker;
                modifyModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Title_Update()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                string productId = product.Id;
                modifyModel.OnGet(productId);
                DeepCopyProduct(ref oldProduct, modifyModel.Product);

                modifyModel.Product.Title = "Updating Title for " + modifyModel.Product.Title;
                modifyModel.OnPost();

                modifyModel.OnGet(productId);
                DeepCopyProduct(ref newProduct, modifyModel.Product);

                // Assert
                Assert.AreEqual(true, modifyModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                modifyModel.Product.Title = oldProduct.Title;
                modifyModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Image_Update()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                string productId = product.Id;
                modifyModel.OnGet(productId);
                DeepCopyProduct(ref oldProduct, modifyModel.Product);

                modifyModel.Product.Image = "https://test.jpg";
                modifyModel.OnPost();

                modifyModel.OnGet(productId);
                DeepCopyProduct(ref newProduct, modifyModel.Product);

                // Assert
                Assert.AreEqual(true, modifyModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                modifyModel.Product.Image = oldProduct.Image;
                modifyModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Price_Update()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                string productId = product.Id;
                modifyModel.OnGet(productId);
                DeepCopyProduct(ref oldProduct, modifyModel.Product);

                modifyModel.Product.Price = oldProduct.Price * 10 ;
                modifyModel.OnPost();

                modifyModel.OnGet(productId);
                DeepCopyProduct(ref newProduct, modifyModel.Product);

                // Assert
                Assert.AreEqual(true, modifyModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                modifyModel.Product.Price = oldProduct.Price;
                modifyModel.OnPost();
            }
        }
        #endregion OnPost

    }
}