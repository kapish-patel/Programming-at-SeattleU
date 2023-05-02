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

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using System.Collections.Generic;

namespace UnitTests.Models
{
    /// <summary>
    /// A class for representing product type Enum model unit tests
    /// </summary>
    public class ProductTypeEnumTest
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

        public static ProductModel productModel;

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
            var MockLoggerDirect = Mock.Of<ILogger<ProductModel>>();

            //Creates product service object for JSON object file
            JsonFileProductService productService;

            //Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a product model object for unit testing
            productModel = new ProductModel()
            {
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        ///Unit test to validate Product Type with valid Health product
        /// </summary>
        [Test]
        public void Get_Product_Type_Valid_Should_Return_Correct_Type_For_Health_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Health;

            // Assert
            Assert.AreEqual("Health Services", ProductTypeEnumExtensions.DisplayName(productModel.ProductType));

        }
        #endregion OnGet


        #region OnGet
        /// <summary>
        ///Unit test to validate Product Type with valid Food product
        /// </summary>
        [Test]
        public void Get_Product_Type_Valid_Should_Return_Correct_Type_For_Food_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Food;

            // Assert
            Assert.AreEqual("Food Services", ProductTypeEnumExtensions.DisplayName(productModel.ProductType));

        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///Unit test to validate Product Type with valid Commercial product
        /// </summary>
        [Test]
        public void Get_Product_Type_Valid_Should_Return_Correct_Type_For_Commercial_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Commercial;

            // Assert
            Assert.AreEqual("Commercial Services", ProductTypeEnumExtensions.DisplayName(productModel.ProductType));

        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///Unit test to validate Product Type with invalid undefined product
        /// </summary>
        [Test]
        public void Get_Product_Type_Invalid_Should_Return_Null_For_Undefined_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Undefined;

            // Assert
            Assert.AreEqual("", ProductTypeEnumExtensions.DisplayName(productModel.ProductType));

        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///Unit test to validate Product Type with valid should not return Household product
        /// </summary>
        [Test]
        public void Get_Product_Type_Valid_Should_Not_Return_Null_For_Household_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Household;

            // Assert
            Assert.AreNotEqual("", ProductTypeEnumExtensions.DisplayName(productModel.ProductType));

        }
        #endregion OnGet
    }
}