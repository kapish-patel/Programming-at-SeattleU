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

            readModel = new ReadModel(productService)
            {
            };
        }

        #endregion TestSetup
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_Empty_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_Negative_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_Equal_To_Greater_Than_10_Product_Id()
        {
            // Arrange

            // Act
            readModel.OnGet("10");

            // Assert
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            Assert.AreEqual(null, readModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Non_Numeric_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Floating_Point_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Alpha_Numeric_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Zero_Product_Id()
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
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Special_Char_Product_Id()
        {
            // Arrange

            // Act
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            for (int i = 0; i < 256; i++)
            {
                char productId = (char)i;
                if (i < '1' || i > '9')
                {
                    
                    readModel.OnGet(productId.ToString());
                    // Assert
                    Assert.AreEqual(null, readModel.Product);
                }
                else
                {
                    readModel.OnGet(productId.ToString());
                    // Assert
                    Assert.AreNotEqual(null, readModel.Product);
                }
            }
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Return_For_Product_Id_From_One_To_Nine()
        {
            // Arrange

            // Act
            Assert.AreEqual(true, readModel.ModelState.IsValid);
            for (int i = 1; i < 10; i++)
            {
                readModel.OnGet(i.ToString());
                // Assert
                Assert.AreNotEqual(null, readModel.Product);
            }
        }
        #endregion OnGet


    }
}