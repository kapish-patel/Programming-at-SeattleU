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

using ContosoCrafts.WebSite.Pages;
using ContosoCrafts.WebSite.Services;

namespace UnitTests.Pages.Product.Index
{
    // This class is used to test index.cshtml
    public class IndexTests
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
        // Initializes a test
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

            pageModel = new IndexModel(MockLoggerDirect, productService);
            {
            };
        }

        #endregion TestSetup
        
        #region OnGet
        [Test]
        public void OnGet_Valid_Empty_Search_String_Should_Return_All_Products()
        {
            // Arrange

            // Act
            pageModel.SearchString = "";
            var result = pageModel.OnGet(pageModel.SearchString);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreNotEqual(null, pageModel.Products);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RazorPages.PageResult", result.ToString());
        }
        #endregion OnGet

        #region OnGet
        [Test]
        public void OnGet_Valid_Null_Search_String_Should_Return_All_Products()
        {
            // Arrange

            // Act
           pageModel.SearchString = null;
           var result = pageModel.OnGet(pageModel.SearchString);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreNotEqual(null, pageModel.Products);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RazorPages.PageResult", result.ToString());
        }
        #endregion OnGet

        #region OnGet
        [Test]
        public void OnGet_Invalid_Search_String_Should_Return_All_Products()
        {
            // Arrange

            // Act
            pageModel.SearchString = "asdfgqwer";
            var result = pageModel.OnGet(pageModel.SearchString);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RazorPages.PageResult", result.ToString());
        }
        #endregion OnGet

        #region OnGet
        [Test]
        public void OnGet_Valid_Search_String_Should_Return_Correct_Product()
        {
            // Arrange

            // Act
            pageModel.SearchString = "Driver";
            var result = pageModel.OnGet(pageModel.SearchString);

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
            Assert.AreEqual(1, pageModel.Products.Count());
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());
        }
        #endregion OnGet
    }

}