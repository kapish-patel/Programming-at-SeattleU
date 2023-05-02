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

namespace UnitTests.Pages.Product.Delete
{
    public class DeleteTest
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

        public static DeleteModel deleteModel;
        JsonFileProductService productService;

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

            var MockLoggerDirect = Mock.Of<ILogger<DeleteModel>>();
            
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            deleteModel = new DeleteModel(productService)
            {
            };
        }
        #endregion TestSetup

        #region OnGet
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

        //Unit test to validate get and set methods of Product Id with valid input
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

        //Unit test to validate OnPost methods for Delete operation with valid input
        #region OnPost
        [Test]
        public void OnPost_Valid_For_Last_Product_Delete_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            var products = productService.GetAllData();

            // Act
            string productId = products.Last().Id;
            deleteModel.OnGet(productId);
            IActionResult result = deleteModel.OnPost();

            // Assert
            Assert.AreEqual(true, deleteModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());
        }
        #endregion OnPost

        //Unit test to validate OnPost methods for Delete operation with invalid Model State
        #region OnPost
        [Test]
        public void OnPost_Invalid_Model_State_Should_Return_Page_Result()
        {
            // Arrange
            var products = TestHelper.ProductService.GetAllData();

            // Act
            string productId = products.Last().Id;
            deleteModel.OnGet(productId);
            deleteModel.ModelState.AddModelError("Region", "Region is mandatory");
            IActionResult result = deleteModel.OnPost();


            // Assert
            Assert.AreNotEqual(true, deleteModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RazorPages.PageResult", result.ToString());

        }
        #endregion OnPost

    }
}
