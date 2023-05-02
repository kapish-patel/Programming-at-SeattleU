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

        #region ProductList
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
        #endregion

        #region SelectProduct
        //test case for select product
        [Test]
        public void SelectProduct_valid_ID_5_should_Return_Content()
        {
            // Arrange
            Services.AddSingleton<JsonFileProductService>(TestHelper.ProductService);

            //Variable for storing static id 
            var id = "moreinfobtn_5";

            //variable page for rendering component names productlist
            var page = RenderComponent<ProductList>();

            // Find button and get all the list of button onthe page
            var button_List = page.FindAll("Button");

            // Find the card with matching ID using button list
            var button = button_List.First(m => m.OuterHtml.Contains(id));

            // Act
            button.Click();

            // Get markup to use for assert
            var pagemarkup = page.Markup;

            // Assert
            Assert.AreEqual(true, pagemarkup.Contains("A Driver is a professional who drives clients around in an efficient, safe and timely manner. In addition to maintaining regular cleaning services for their vehicle as well as managing payments on time each week/monthly cycle goes by; drivers also plan routes based on road conditions."));
        }
        #endregion
        #region submitRating and GetCurrentRating
        //test case for SubmitRating and getCurrentRating
        [Test]
        public void Submitrating_Valid_ID_Click_Nonstar_Should_Increment_Count_And_Star()
        {
            // Arrange
            Services.AddSingleton<JsonFileProductService>(TestHelper.ProductService);

            //Variable for storing static id 
            var id = "moreinfobtn_5";

            //variable page for rendering component names productlist
            var page = RenderComponent<ProductList>();

            // Find button and get all the list of button onthe page
            var button_List = page.FindAll("Button");

            // Find the card with matching ID using button list
            var button = button_List.First(m => m.OuterHtml.Contains(id));

            // click button
            button.Click();

            //get the markup of the page and 
            var pagemarkup = page.Markup;

            //find the span(star) button list and store in variable 
            var star_btn_list = page.FindAll("span");

            //get vote count from the star_btn_list[1]
            var vote_count_span = star_btn_list[1];

            var vote_count_string = vote_count_span.OuterHtml;

            //get the first star from list it will be fa fa-star 
            var Star_btn = star_btn_list.First(m => !string.IsNullOrEmpty(m.ClassName) && m.ClassName.Contains("fa fa-star"));

            //save html for comparison
            var pre_star_change = Star_btn.OuterHtml;

            // Act

            //click star button
            Star_btn.Click();

            //get markup to Assert
            var btn_markup = page.Markup;

            //get he span(star) buttons
            star_btn_list = page.FindAll("span");

            //get the vote count
            var post_vot_count = star_btn_list[1];
            var post_vote_count_string = post_vot_count.OuterHtml;

            //get the last star item class would be fa fa-star checked
            Star_btn = star_btn_list.First(m => !string.IsNullOrEmpty(m.ClassName) && m.ClassName.Contains("fa fa-star checked"));

            //save html 
            var post_star_change = Star_btn.OuterHtml;

            //for 2 votes

            //click star button
            Star_btn.Click();

            //get markup to Assert
            var btn_markup_2 = page.Markup;

            //get he span(star) buttons
            star_btn_list = page.FindAll("span");

            //get the vote count
            var post_vot_count_2 = star_btn_list[1];
            var post_vote_count_string_2 = post_vot_count_2.OuterHtml;

            //get the last star item class would be fa fa-star checked
            Star_btn = star_btn_list.First(m => !string.IsNullOrEmpty(m.ClassName) && m.ClassName.Contains("fa fa-star checked"));

            //save html 
            var post_star_change_2 = Star_btn.OuterHtml;

            //end hear

            //Assert
            //confirms that there is no vote yet,1 vote or the string which 
            Assert.AreEqual(true, vote_count_string.Contains("Be the first to vote!"));
            Assert.AreEqual(true, post_vote_count_string.Contains("1 Vote"));
            Assert.AreEqual(true, post_vote_count_string_2.Contains("2 Votes"));
            Assert.AreEqual(false, vote_count_string.Equals(post_vote_count_string));
        }
        #endregion
    }
}