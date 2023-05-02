using System.Linq;

using Microsoft.Extensions.DependencyInjection;

using Bunit;
using NUnit.Framework;

using ContosoCrafts.WebSite.Components;
using ContosoCrafts.WebSite.Services;
using ContosoCrafts.WebSite.Models;

namespace UnitTests.Components
{
    //This class is used to test ProductList.razor page
    public class ProductListTests : BunitTestContext
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion TestSetup
        //This is used to test if the return value is as expected.
        [Test]
        public void ProductList_Valid_Rendering_Should_Return_Content_For_All_Products()
        {
            // Arrange
            Services.AddSingleton<JsonFileProductService>(TestHelper.ProductService);

            // Act
            var page = RenderComponent<ProductList>();

            // Get the Cards returned
            var result = page.Markup;
            var products = TestHelper.ProductService.GetAllData();
            foreach (ProductModel product in products)
            {
                // Assert
                Assert.AreEqual(true, result.Contains(product.Title));
            }
        }
    }
}