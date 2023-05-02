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
using System.Text.Json;

namespace UnitTests.Models
{
    public class ProductModelTest
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

        //Unit test to validate get and set methods of Product Id with valid input
        #region OnGet
        [Test]
        public void Get_ID_Valid_Should_Return_Set_ID_For_Product()
        {
            // Arrange

            // Act
            productModel.Id = "1";

            // Assert
            Assert.AreEqual("1", productModel.Id);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Id with invalid input
        #region OnGet
        [Test]
        public void Get_ID_Invalid_Should_Return_Different_ID_For_Product()
        {
            // Arrange

            // Act
            productModel.Id = "1";

            // Assert
            Assert.AreNotEqual("2", productModel.Id);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product maker with valid input
        #region OnGet
        [Test]
        public void Get_Maker_Valid_Should_Return_Set_Maker_For_Product()
        {
            // Arrange

            // Act
            productModel.Maker = "New Maker";

            // Assert
            Assert.AreEqual("New Maker", productModel.Maker);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product maker with invalid input
        #region OnGet
        [Test]
        public void Get_Maker_Invalid_Should_Return_Different_Maker_For_Product()
        {
            // Arrange

            // Act
            productModel.Maker = "New maker";

            // Assert
            Assert.AreNotEqual("Old Maker", productModel.Maker);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product title with valid input
        #region OnGet
        [Test]
        public void Get_Title_Valid_Should_Return_Set_Title_For_Product()
        {
            // Arrange

            // Act
            productModel.Title = "New Title";

            // Assert
            Assert.AreEqual("New Title", productModel.Title);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product title with invalid input
        #region OnGet
        [Test]
        public void Get_Title_Invalid_Should_Return_Different_Title_For_Product()
        {
            // Arrange

            // Act
            productModel.Title = "New Title";

            // Assert
            Assert.AreNotEqual("Old Title", productModel.Title);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product image with valid input
        #region OnGet
        [Test]
        public void Get_Image_Valid_Should_Return_Set_Image_For_Product()
        {
            // Arrange

            // Act
            productModel.Image = "New Image";

            // Assert
            Assert.AreEqual("New Image", productModel.Image);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product image with invalid input
        #region OnGet
        [Test]
        public void Get_Image_Invalid_Should_Return_Different_Image_For_Product()
        {
            // Arrange

            // Act
            productModel.Image = "New Image";

            // Assert
            Assert.AreNotEqual("Old Image", productModel.Image);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product URL with valid input
        #region OnGet
        [Test]
        public void Get_Url_Valid_Should_Return_Set_Url_For_Product()
        {
            // Arrange

            // Act
            productModel.Url = "New URL";

            // Assert
            Assert.AreEqual("New URL", productModel.Url);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product URL with invalid input
        #region OnGet
        [Test]
        public void Get_Url_Invalid_Should_Return_Different_Url_For_Product()
        {
            // Arrange

            // Act
            productModel.Url = "New URL";

            // Assert
            Assert.AreNotEqual("Old URL", productModel.Url);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Description with valid input
        #region OnGet
        [Test]
        public void Get_Description_Valid_Should_Return_Set_Description_For_Product()
        {
            // Arrange

            // Act
            productModel.Description = "New Description";

            // Assert
            Assert.AreEqual("New Description", productModel.Description);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Description with invalid input
        #region OnGet
        [Test]
        public void Get_Description_Invalid_Should_Return_Different_Description_For_Product()
        {
            // Arrange

            // Act
            productModel.Description = "New Description";

            // Assert
            Assert.AreNotEqual("Old Description", productModel.Description);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Quantity with valid input
        #region OnGet
        [Test]
        public void Get_Quantity_Valid_Should_Return_Set_Quantity_For_Product()
        {
            // Arrange

            // Act
            productModel.Quantity = "New Quantity";

            // Assert
            Assert.AreEqual("New Quantity", productModel.Quantity);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Quantity with invalid input
        #region OnGet
        [Test]
        public void Get_Quantity_Invalid_Should_Return_Different_Quantity_For_Product()
        {
            // Arrange

            // Act
            productModel.Quantity = "New Quantity";

            // Assert
            Assert.AreNotEqual("Old Quantity", productModel.Quantity);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Ratings with valid input
        #region OnGet
        [Test]
        public void Get_Ratings_Valid_Should_Return_Set_Ratings_For_Product()
        {
            // Arrange
            int[] ratings = new int[1];

            // Act
            ratings[0] = 1;
            productModel.Ratings = ratings;

            // Assert
            Assert.AreEqual(ratings, productModel.Ratings);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Ratings with invalid input
        #region OnGet
        [Test]
        public void Get_Ratings_Invalid_Should_Return_Different_Ratings_For_Product()
        {
            // Arrange
            int[] ratings = new int[1];
            int[] newRatings = new int[2];

            // Act
            ratings[0] = 1;
            productModel.Ratings = ratings;
            newRatings[0] = 1;
            newRatings[1] = 2;

            // Assert
            Assert.AreNotEqual(newRatings, productModel.Ratings);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Price with valid input
        #region OnGet
        [Test]
        public void Get_Price_Valid_Should_Return_Set_Price_For_Product()
        {
            // Arrange

            // Act
            productModel.Price = 10;

            // Assert
            Assert.AreEqual(10, productModel.Price);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Price with invalid input
        #region OnGet
        [Test]
        public void Get_Price_Invalid_Should_Return_Different_Price_For_Product()
        {
            // Arrange

            // Act
            productModel.Price = 10;

            // Assert
            Assert.AreNotEqual(100, productModel.Price);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Comment List with valid input
        #region OnGet
        [Test]
        public void Get_Comment_List_Valid_Should_Return_Set_Comment_List_For_Product()
        {
            // Arrange
            List<CommentModel> commentList = new List<CommentModel>();
            CommentModel commentModel = new CommentModel();

            // Act
            commentModel.Id = "1";
            commentModel.Comment = "New Comment";
            commentList.Add(commentModel);
            productModel.CommentList = commentList;

            // Assert
            Assert.AreEqual(commentList, productModel.CommentList);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Comment List with invalid input
        #region OnGet
        [Test]
        public void Get_Comment_List_Invalid_Should_Return_Different_Comment_List_For_Product()
        {
            // Arrange
            List<CommentModel> commentList = new List<CommentModel>();
            CommentModel commentModel = new CommentModel();
            CommentModel newCommentModel = new CommentModel();

            // Act
            commentModel.Id = "1";
            commentModel.Comment = "Old Comment";
            newCommentModel.Id = "2";
            newCommentModel.Comment = "new Comment";
            commentList.Add(commentModel);
            productModel.CommentList = new List<CommentModel>();
            productModel.CommentList.Add(newCommentModel); 

            // Assert
            Assert.AreNotEqual(commentList, productModel.CommentList);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Type with valid input
        #region OnGet
        [Test]
        public void Get_Product_Type_Valid_Should_Return_Set_Type_For_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Health;

            // Assert
            Assert.AreEqual(ProductTypeEnum.Health, productModel.ProductType);

        }
        #endregion OnGet

        //Unit test to validate get and set methods of Product Type with invalid input
        #region OnGet
        [Test]
        public void Get_Product_Type_Invalid_Should_Return_Different_Type_For_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();

            // Act    
            productModel.ProductType = ProductTypeEnum.Health;

            // Assert
            Assert.AreNotEqual(ProductTypeEnum.Food, productModel.ProductType);

        }
        #endregion OnGet



        //Unit test to validate string returned by Json Serializer
        #region JsonSerializer
        [Test]
        public void Json_Serializer_Valid_Should_Non_Empty_String_Of_Product()
        {
            // Arrange
            productModel.ProductType = new ProductTypeEnum();


            // Act    
            string productModelStr = productModel.ToString();

            // Assert
            Assert.AreNotEqual(null, productModelStr);

        }
        #endregion JsonSerializer

    }
}