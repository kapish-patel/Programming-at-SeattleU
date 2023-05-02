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

namespace UnitTests.Pages.Product.Read
{
    /// <summary>
    /// A class is used to test read.cshtml
    /// </summary>
    public class ReadTests
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

        public static ReadModel readModel;
        // Initializeds test
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

            //Creates a read model object for unit testing
            readModel = new ReadModel(productService)
            {
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for empty product ID
        /// </summary>
        [Test]
        public void OnGet_Invalid_Empty_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for negative product ID
        /// </summary>
        [Test]
        public void OnGet_Invalid_Negative_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("-1");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet


        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for non numneric product id
        /// </summary>
        [Test]
        public void OnGet_Invalid_For_Non_Numeric_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("abc");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for product id in floating point 
        /// </summary>
        [Test]
        public void OnGet_Invalid_For_Floating_Point_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("0.1");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for product id in alpha numeric
        /// </summary>
        [Test]
        public void OnGet_Invalid_For_Alpha_Numeric_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("a1");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for product id with value zero
        /// </summary>
        [Test]
        public void OnGet_Invalid_For_Zero_Product_Id_Should_Return_Null()
        {
            // Arrange

            // Act
            readModel.OnGet("0");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        ///This is used to test OnGet method for product id with special char
        /// </summary>
        [Test]
        public void OnGet_Invalid_For_Special_Char_Product_Id_Should_Return_Null()
        {
            // Arrange
            string productId = "^";
            // Act
            readModel.OnGet(productId);
            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet

    }
}