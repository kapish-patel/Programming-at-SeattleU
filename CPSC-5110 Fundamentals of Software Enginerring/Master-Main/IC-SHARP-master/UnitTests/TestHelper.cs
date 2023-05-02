
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Routing;
using Moq;
using ContosoCrafts.WebSite.Services;
namespace UnitTests
{
    /// <summary>
    /// Helper to hold the web start settings
    ///
    /// HttpClient
    /// 
    /// Action Contect
    /// 
    /// The View Data and Teamp Data
    /// 
    /// The Product Service
    /// </summary>
    public static class TestHelper
    {
        public static Mock<IWebHostEnvironment> MockWebHostEnvironment;
        public static IUrlHelperFactory UrlHelperFactory;
        public static DefaultHttpContext HttpContextDefault;
        public static IWebHostEnvironment WebHostEnvironment;
        public static ModelStateDictionary ModelState;
        public static ActionContext ActionContext;
        public static EmptyModelMetadataProvider ModelMetadataProvider;
        public static ViewDataDictionary ViewData;
        public static TempDataDictionary TempData;
        public static PageContext PageContext;
        public static JsonFileProductService ProductService;

        /// <summary>
        /// Default Constructor
        /// </summary>
        static TestHelper()
        {
            MockWebHostEnvironment = new Mock<IWebHostEnvironment>();
            MockWebHostEnvironment.Setup(m => m.EnvironmentName).Returns("Hosting:UnitTestEnvironment");
            MockWebHostEnvironment.Setup(m => m.WebRootPath).Returns(TestFixture.DataWebRootPath);
            MockWebHostEnvironment.Setup(m => m.ContentRootPath).Returns(TestFixture.DataContentRootPath);

            //Creates a new object for http context
            HttpContextDefault = new DefaultHttpContext()
            {
                TraceIdentifier = "trace",
            };
            HttpContextDefault.HttpContext.TraceIdentifier = "trace";

            //Creates a new object for model state
            ModelState = new ModelStateDictionary();

            //Creates a new object for action context based on http context and model state
            ActionContext = new ActionContext(HttpContextDefault, HttpContextDefault.GetRouteData(), new PageActionDescriptor(), ModelState);

            //Creates a new object for metadata provider
            ModelMetadataProvider = new EmptyModelMetadataProvider();

            //Creates a new object of View Data dictionary
            ViewData = new ViewDataDictionary(ModelMetadataProvider, ModelState);

            //Creates a new object of Temp Data dictionary
            TempData = new TempDataDictionary(HttpContextDefault, Mock.Of<ITempDataProvider>());

            //Creates a new object of page context using action context
            PageContext = new PageContext(ActionContext)
            {
                ViewData = ViewData,
                HttpContext = HttpContextDefault
            };

            //Created new product service object for the mock webhost environment
            ProductService = new JsonFileProductService(MockWebHostEnvironment.Object);

            JsonFileProductService productService;

            //Creates new object for JsonFileProductService
            productService = new JsonFileProductService(TestHelper.MockWebHostEnvironment.Object);
        }
    }
}