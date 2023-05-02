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

namespace UnitTests.Models
{
    /// <summary>
    /// A class for representing Comment unit tests
    /// </summary>
    public class CommentTest
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

        public static CommentModel commentModel;

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
            var MockLoggerDirect = Mock.Of<ILogger<CommentModel>>();

            //Creates product service object for JSON object file
            JsonFileProductService productService;

            //Created new product service object for the mock webhost environment
            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            //Creates a product conroller object for unit testing
            commentModel = new CommentModel()
            {
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        /// Unit test to validate get and set methods of Comment Id with valid input
        /// </summary>
        [Test]
        public void Get_Id_Valid_Should_Return_Comment_For_Set_Id()
        {
            // Arrange

            // Act
            commentModel.Id = "1";

            // Assert
            Assert.AreEqual("1", commentModel.Id);

        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        /// Unit test to validate get and set methods of Comment Id with invalid input
        /// </summary>
        [Test]
        public void Get_Id_Invalid_Should_Return_Different_Id_Comment()
        {
            // Arrange

            // Act
            commentModel.Id = "1";

            // Assert
            Assert.AreNotEqual("2", commentModel.Id);

        }
        #endregion OnGet

        #region OnGet
        /// <summary>
        /// Unit test to validate get and set methods of Comment message with valid input
        /// </summary>
        [Test]
        public void Get_Comment_Valid_Should_Return_Comment_For_Set_Comment()
        {
            // Arrange

            // Act
            commentModel.Comment = "Not really a comment";

            // Assert
            Assert.AreEqual("Not really a comment", commentModel.Comment);

        }
        #endregion OnGet


        #region OnGet
        /// <summary>
        /// Unit test to validate get and set methods of Comment message with invalid input
        /// </summary>
        [Test]
        public void Get_Comment_Invalid_Should_Return_Different_Comment()
        {
            // Arrange

            // Act
            commentModel.Comment = "Not really a comment";

            // Assert
            Assert.AreNotEqual("Really a comment", commentModel.Comment);

        }
        #endregion OnGet
    }
}