using ContosoCrafts.WebSite.Services;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Routing;
using ContosoCrafts.WebSite.Pages.Product;
using ContosoCrafts.WebSite.Models;
using Microsoft.AspNetCore;

namespace UnitTests.Pages.Product.Delete
{
    public class DeleteTest
    {
        /// <summary>
        /// A class for representing delete unit tests
        /// </summary>
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

        public static DeleteModel deleteModel;
        public static ProductModel product;
        JsonFileProductService productService;

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
            var MockLoggerDirect = Mock.Of<ILogger<DeleteModel>>();

            // Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a delete model object for unit testing
            deleteModel = new DeleteModel(productService);

            //Creates a product model to store temporary product and delete
            product = new ProductModel();

        }
        #endregion TestSetup

        #region OnGet
        /// <summary>
        /// unit test to validate get method for valid product ID
        /// </summary>
        [Test]
        public void OnGet_Valid_Should_Return_Product()
        {
            // Arrange

            // Act
            var Id = "4";
            deleteModel.OnGet(Id);

            // Assert
            Assert.AreEqual(true, deleteModel.ModelState.IsValid);
        }
        #endregion OnGet

        /// <summary>
        ///Unit test to validate get and set methods of Product Id with valid input
        /// </summary>
        #region OnGet
        [Test]
        public void Get_ID_Valid_Should_Return_Set_ID_For_Product()
        {
            // Arrange

            // Act
            deleteModel.Product = new ProductModel();
            deleteModel.Product.Id = "1";

            // Assert
            Assert.AreEqual("1", deleteModel.Product.Id);

        }
        #endregion OnGet


        #region OnPost
        /// <summary>
        ///Unit test to validate OnPost methods for Delete operation with valid input
        /// </summary>
        [Test]
        public void OnPost_Valid_For_Last_Product_Delete_Should_Return_Redirect_Page_Result()
        {

            // Arrange

            product.Maker = "Temporary product maker";
            product.Title = "Temporary product title";
            product.Description = "Temporary product description";
            
            //Create a new temporary product to test delete functionality
            ProductModel newProduct =  productService.CreateData(product);

            //Creates a delete model object for unit testing
            deleteModel = new DeleteModel(productService);
            // Act
            deleteModel.OnGet(newProduct.Id);
            IActionResult result = deleteModel.OnPost();

            // Assert
            Assert.AreEqual(true, deleteModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());
        }
        #endregion OnPost

    }
}
