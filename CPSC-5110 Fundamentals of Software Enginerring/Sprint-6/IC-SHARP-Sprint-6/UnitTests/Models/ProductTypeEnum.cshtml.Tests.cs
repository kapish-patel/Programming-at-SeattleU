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

            var MockLoggerDirect = Mock.Of<ILogger<ProductModel>>();
            JsonFileProductService productService;

            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            productModel = new ProductModel()
            {
            };
        }

        #endregion TestSetup

       
        //Unit test to validate Product Type with valid Health product
        #region OnGet
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

        //Unit test to validate Product Type with valid Food product
        #region OnGet
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

        //Unit test to validate Product Type with valid Commercial product
        #region OnGet
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

        //Unit test to validate Product Type with invalid undefined product
        #region OnGet
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

        //Unit test to validate Product Type with valid should not return Household product
        #region OnGet
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