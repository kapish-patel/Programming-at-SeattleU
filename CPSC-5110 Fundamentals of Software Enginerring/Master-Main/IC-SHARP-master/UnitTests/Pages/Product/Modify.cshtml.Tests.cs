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

            //Creates a mock host environment
            var mockWebHostEnvironment = new Mock<IWebHostEnvironment>();
            mockWebHostEnvironment.Setup(m => m.EnvironmentName).Returns("Hosting:UnitTestEnvironment");
            mockWebHostEnvironment.Setup(m => m.WebRootPath).Returns("../../../../src/bin/Debug/net6.0/wwwroot");
            mockWebHostEnvironment.Setup(m => m.ContentRootPath).Returns("./data/");

            //Initializes a mock logger for the model
            var MockLoggerDirect = Mock.Of<ILogger<IndexModel>>();

            //Creates product service object for JSON object file
            JsonFileProductService productService;

            //Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a modify model object for unit testing
            modifyModel = new ModifyModel(productService)
            {
            };
        }

        /// Function to perform a Deep Copy on the product
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
        /// <summary>
        /// Unit test to validate get method for empty product ID  
        /// </summary>
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
        /// <summary>
        /// Unit test to validate get method for negative product ID  
        /// </summary>
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
        /// <summary>
        /// Unit test to validate get method for floating point product ID  
        /// </summary>
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
        /// <summary>
        /// Unit test to validate get method for zero-valued product ID  
        /// </summary>
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
        /// <summary>
        /// Unit test to validate get method for special character product ID  
        /// </summary>
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
        /// <summary>
        /// Unit test to validate post method for updating product description  
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Product_Description_Update_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var product = TestHelper.ProductService.GetAllData().First();      
            ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
            
            // Act
            string productId = product.Id;

            //Get copy of product based on the ID
            modifyModel.OnGet(productId);

            //Save a copy of the product
            DeepCopyProduct(ref oldProduct, modifyModel.Product);

            //Updating the product Description
            modifyModel.Product.Description = "Updating Description for " + modifyModel.Product.Title;
            IActionResult result = modifyModel.OnPost();

            //Get another copy of the product
            modifyModel.OnGet(productId);

            //Save a copy of the new product
            DeepCopyProduct(ref newProduct, modifyModel.Product);

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreNotEqual(oldProduct, newProduct);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Restoring the old value after the test is complete
            modifyModel.Product.Description = oldProduct.Description;
            modifyModel.OnPost();
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for updating product maker  
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Product_Maker_Update_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var product = TestHelper.ProductService.GetAllData().First();
            ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();

            // Act
            string productId = product.Id;

            //Get a copy of the product based on ID
            modifyModel.OnGet(productId);

            //Save a copy of the product
            DeepCopyProduct(ref oldProduct, modifyModel.Product);

            //Updating the product maker
            modifyModel.Product.Maker = "Updating maker for " + modifyModel.Product.Title;
            IActionResult result = modifyModel.OnPost();

            //Get another copy of the product
            modifyModel.OnGet(productId);

            //Save a copy of the new product
            DeepCopyProduct(ref newProduct, modifyModel.Product);

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreNotEqual(oldProduct, newProduct);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Restoring the old value after the test is complete
            modifyModel.Product.Maker = oldProduct.Maker;
            modifyModel.OnPost();
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for updating product title  
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Product_Title_Update_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var product = TestHelper.ProductService.GetAllData().First();
            ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();

            // Act
            string productId = product.Id;

            //Get product based on ID
            modifyModel.OnGet(productId);

            //Save a copy of the product
            DeepCopyProduct(ref oldProduct, modifyModel.Product);

            //Updating the product title
            modifyModel.Product.Title = "Updating Title for " + modifyModel.Product.Title;
            IActionResult result = modifyModel.OnPost();

            //Get anothe rcopy of the product
            modifyModel.OnGet(productId);

            //Save a copy of the new product
            DeepCopyProduct(ref newProduct, modifyModel.Product);

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreNotEqual(oldProduct, newProduct);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Restoring the old value after the test is complete
            modifyModel.Product.Title = oldProduct.Title;
            modifyModel.OnPost();
            
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for updating product image  
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Product_Image_Update_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var product = TestHelper.ProductService.GetAllData().First();
            ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();

            // Act
            string productId = product.Id;
            modifyModel.OnGet(productId);

            //Save a copy of the product
            DeepCopyProduct(ref oldProduct, modifyModel.Product);

            //Updating the product image
            modifyModel.Product.Image = "https://test.jpg";
            IActionResult result = modifyModel.OnPost();
            
            //Get the another copy of product
            modifyModel.OnGet(productId);

            //Save a copy of the new product
            DeepCopyProduct(ref newProduct, modifyModel.Product);

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreNotEqual(oldProduct, newProduct);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Restoring the old value after the test is complete
            modifyModel.Product.Image = oldProduct.Image;
            modifyModel.OnPost();
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for updating product price  
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Product_Price_Update_Should_Return_Redirect_Page_Result ()
        {
            // Arrange
            var product = TestHelper.ProductService.GetAllData().First();
            ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
            // Act
            string productId = product.Id;

            //Get product based on ID 
            modifyModel.OnGet(productId);

            //Save a copy of the product
            DeepCopyProduct(ref oldProduct, modifyModel.Product);

            //Updating the product price
            modifyModel.Product.Price = oldProduct.Price * 10 ;
            IActionResult result = modifyModel.OnPost();

            //Get first product
            modifyModel.OnGet(productId);

            //Save a copy of the new product
            DeepCopyProduct(ref newProduct, modifyModel.Product);

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreNotEqual(oldProduct, newProduct);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Restoring the old value after the test is complete
            modifyModel.Product.Price = oldProduct.Price;
            modifyModel.OnPost();
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for not updating any product detail
        /// </summary>
        [Test]
        public void OnPost_Valid_For_No_Product_Update_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            // Act
            string productId = products.First().Id;

            //Get product
            modifyModel.OnGet(productId);           

            //Invoke OnPost method
            IActionResult result = modifyModel.OnPost();

            // Assert
            Assert.AreEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());
            
        }
        #endregion OnPost

        #region OnPost
        /// <summary>
        /// Unit test to validate post method for invalid model state 
        /// </summary>
        [Test]
        public void OnPost_Invalid_Model_State_Should_Return_Page_Result()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();
            // Act
            string productId = products.First().Id;

            //Get first product
            modifyModel.OnGet(productId);

            //Set model state to an error
            modifyModel.ModelState.AddModelError("Region", "Region is mandatory");

            //Invoke OnPost on invalid modify model state
            IActionResult result = modifyModel.OnPost();


            // Assert
            Assert.AreNotEqual(true, modifyModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

        }
        #endregion OnPost
    }
}