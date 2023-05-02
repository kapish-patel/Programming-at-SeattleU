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

namespace UnitTests.Pages.Product.Create
{
    /// <summary>
    /// A class for representing create unit tests
    /// </summary>
    public class CreateTest
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

        public static CreateModel createModel;
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
            var MockLoggerDirect = Mock.Of<ILogger<IndexModel>>();

            //Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a create model object for unit testing
            createModel = new CreateModel(productService);

            //Creates a product model to store temporary product and delete
            product = new ProductModel();
        }

        #endregion TestSetup

        #region OnPost
        /// <summary>
        /// Unit test to validate post method returns page
        /// </summary>
        [Test]
        public void OnPost_Valid_Should_Return_Redirect_Page_Result()
        {
            // Arrange
            product.Id = "0000-0001";
            product.Maker = "Temporary product maker";
            product.Title = "Temporary product title";
            product.Description = "Temporary product description";

            // Act
            var result = createModel.OnPost(product);
            
            // Assert
            Assert.AreEqual(true, createModel.ModelState.IsValid);
            Assert.AreEqual("Microsoft.AspNetCore.Mvc.RedirectToPageResult", result.ToString());

            //Revert
            productService.DeleteData(product.Id);
        }
        #endregion OnPost
    }
}