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
using System;
using Moq;

using NUnit.Framework;

using ContosoCrafts.WebSite.Pages.Product;
using ContosoCrafts.WebSite.Services;

namespace UnitTests.Pages.Product.Index
{
    /// <summary>
    /// A class for representing indextmodel unit tests
    /// </summary>
    public class IndexTest
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

        public static IndexModel pageModel;

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

            //Creates a index model object for unit testing
            pageModel = new IndexModel(productService)
            {
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        /// Unit test to validate search functionality with empty search string
        /// should return all products
        /// </summary>
        [Test]
        public void OnGet_Valid_Empty_Search_String_Should_Return_All_Products()
        {
            // Arrange

            // Act
            pageModel.OnGet("");

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreNotEqual(null, pageModel.Products);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        /// Unit test to validate search functionality with null search string 
        /// should return all products
        /// </summary>
        [Test]
        public void OnGet_Valid_Null_Search_String_Should_Return_All_Products()
        {
            // Arrange

            // Act
            pageModel.OnGet(null);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreNotEqual(null, pageModel.Products);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        /// Unit test to validate search functionality with invalid search string 
        /// should not return any product
        /// </summary>
        [Test]
        public void OnGet_Invalid_Search_String_Should_Return_Not_Any_Product()
        {
            // Arrange

            // Act
            pageModel.SearchString = "asdfgqwer";
            pageModel.OnGet(pageModel.SearchString);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreEqual(0, pageModel.Products.Count());
        }
        #endregion OnGet
    }
}