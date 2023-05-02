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
using ContosoCrafts.WebSite.Models;

namespace UnitTests.Pages.Product.Update
{
    public class UpdateTests
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

        public static UpdateModel updateModel;

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

            updateModel = new UpdateModel(productService)
            {
            };
        }

        //Function to perform a Deep Copy on the product
        public static void DeepCopyProduct(ref ProductModel copyProduct, ProductModel product)
        {

            copyProduct.Id = product.Id;
            copyProduct.Maker = product.Maker;
            copyProduct.Image = product.Image;
            copyProduct.Url = product.Url;
            copyProduct.Title = product.Title;
            copyProduct.Description = product.Description;
            copyProduct.Ratings = product.Ratings;
            copyProduct.ProductType = product.ProductType;
            copyProduct.Quantity = product.Quantity;
            copyProduct.Price = product.Price;
            copyProduct.CommentList = product.CommentList;

        }

        #endregion TestSetup
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_Empty_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_Negative_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("-1");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_Equal_To_Greater_Than_10_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("10");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Non_Numeric_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("abc");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Floating_Point_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("0.1");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Alpha_Numeric_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("a1");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Zero_Product_Id()
        {
            // Arrange

            // Act
            updateModel.OnGet("0");

            // Assert
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            Assert.AreEqual(null, updateModel.Product);
        }
        #endregion OnGet
        #region OnGet
        [Test]
        public void OnGet_Valid_Should_Not_Return_For_Special_Char_Product_Id()
        {
            // Arrange

            // Act
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            for (int i = 0; i < 256; i++)
            {
                char productId = (char)i;
                if (i < '1' || i > '9')
                {
                    
                    updateModel.OnGet(productId.ToString());
                    // Assert
                    Assert.AreEqual(null, updateModel.Product);
                }
                else
                {
                    updateModel.OnGet(productId.ToString());
                    // Assert
                    Assert.AreNotEqual(null, updateModel.Product);
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
            Assert.AreEqual(true, updateModel.ModelState.IsValid);
            for (int i = 1; i < 10; i++)
            {
                updateModel.OnGet(i.ToString());
                // Assert
                Assert.AreNotEqual(null, updateModel.Product);
            }
        }
        #endregion OnGet
        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Description_Update_From_One_To_Nine()
        {
            // Arrange

            for (int i = 1; i < 10; i++)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                int productId = i;
                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref oldProduct, updateModel.Product);

                updateModel.Product.Description = "Updating Description for " + updateModel.Product.Title;
                updateModel.OnPost();

                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref newProduct, updateModel.Product);

                // Assert
                Assert.AreEqual(true, updateModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                updateModel.Product.Description = oldProduct.Description;
                updateModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Maker_Update_From_One_To_Nine()
        {
            // Arrange

            for (int i = 1; i < 10; i++)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                int productId = i;
                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref oldProduct, updateModel.Product);

                updateModel.Product.Maker = "Updating maker for " + updateModel.Product.Title;
                updateModel.OnPost();

                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref newProduct, updateModel.Product);

                // Assert
                Assert.AreEqual(true, updateModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                updateModel.Product.Maker = oldProduct.Maker;
                updateModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Title_Update_From_One_To_Nine()
        {
            // Arrange

            for (int i = 1; i < 10; i++)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                int productId = i;
                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref oldProduct, updateModel.Product);

                updateModel.Product.Title = "Updating Title for " + updateModel.Product.Title;
                updateModel.OnPost();

                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref newProduct, updateModel.Product);

                // Assert
                Assert.AreEqual(true, updateModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                updateModel.Product.Title = oldProduct.Title;
                updateModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Image_Update_From_One_To_Nine()
        {
            // Arrange

            for (int i = 1; i < 10; i++)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                int productId = i;
                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref oldProduct, updateModel.Product);

                updateModel.Product.Image = "https://test.jpg";
                updateModel.OnPost();

                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref newProduct, updateModel.Product);

                // Assert
                Assert.AreEqual(true, updateModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                updateModel.Product.Image = oldProduct.Image;
                updateModel.OnPost();
            }
        }
        #endregion OnPost

        #region OnPost
        [Test]
        public void OnPost_Valid_For_Product_Price_Update_From_One_To_Nine()
        {
            // Arrange

            for (int i = 1; i < 10; i++)
            {

                ProductModel oldProduct = new ProductModel(), newProduct = new ProductModel();
                // Act
                int productId = i;
                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref oldProduct, updateModel.Product);

                updateModel.Product.Price = oldProduct.Price * 10 ;
                updateModel.OnPost();

                updateModel.OnGet(productId.ToString());
                DeepCopyProduct(ref newProduct, updateModel.Product);

                // Assert
                Assert.AreEqual(true, updateModel.ModelState.IsValid);
                Assert.AreNotEqual(oldProduct, newProduct);

                //Restoring the old value after the test is complete
                updateModel.Product.Price = oldProduct.Price;
                updateModel.OnPost();
            }
        }
        #endregion OnPost

    }
}