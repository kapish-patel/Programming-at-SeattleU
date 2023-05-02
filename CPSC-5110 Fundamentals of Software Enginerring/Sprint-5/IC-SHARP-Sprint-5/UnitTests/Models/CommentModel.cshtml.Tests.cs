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

            var MockLoggerDirect = Mock.Of<ILogger<CommentModel>>();
            JsonFileProductService productService;

            productService = new JsonFileProductService(mockWebHostEnvironment.Object);

            commentModel = new CommentModel()
            {
            };
        }

        #endregion TestSetup

        //Unit test to validate get and set methods of Comment Id with valid input
        #region OnGet
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

        //Unit test to validate get and set methods of Comment Id with invalid input
        #region OnGet
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

        //Unit test to validate get and set methods of Comment message with valid input
        #region OnGet
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

        //Unit test to validate get and set methods of Comment message with invalid input
        #region OnGet
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