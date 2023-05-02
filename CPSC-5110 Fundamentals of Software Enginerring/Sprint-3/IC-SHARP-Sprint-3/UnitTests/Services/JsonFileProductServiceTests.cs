        using System.Linq;

        using Microsoft.AspNetCore.Mvc;

        using NUnit.Framework;

        using ContosoCrafts.WebSite.Models;

    namespace UnitTests.Pages.Product.AddRating
    {
        public class JsonFileProductServiceTests
        {
            #region TestSetup

            [SetUp]
            public void TestInitialize()
            {
            }

            #endregion TestSetup

            #region AddRating
            [Test]
            public void AddRating_Valid_pass_Rating_three_should_return_true()
            {
                // Arrange
                var data = TestHelper.ProductService.GetAllData().Last();


                // Act
                var result = TestHelper.ProductService.AddRating(data.Id, 3);

                // Assert
                Assert.AreEqual(true, result);
            }
        [Test]
        public void AddRating_Valid_pass_Rating_two_should_return_true()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().Last();


            // Act
            var result = TestHelper.ProductService.AddRating(data.Id, 2);

            // Assert
            Assert.AreEqual(true, result);
        }
        [Test]
        public void AddRating_InValid_ProductID_Incorrect_Should_Return_False()
        {
            // Arrange

            // Act
            var result = TestHelper.ProductService.AddRating("Welcome", 1);

            // Assert
            Assert.AreEqual(false, result);
        }


        [Test]
        public void AddRating_Product_Rate_more_five_Should_Return_False()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().First();

            // Act
            var result = TestHelper.ProductService.AddRating(data.Id, 6);

            // Assert
            Assert.AreEqual(false, result);
        }
        [Test]
        public void AddRating_Product_Rate_less_three_Should_Return_False()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().First();

            // Act
            var result = TestHelper.ProductService.AddRating(data.Id, 2);

            // Assert
            Assert.AreEqual(true, result);
        }

        [Test]
        public void AddRating_InValid_ProductID_less_zero_Should_Return_False()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().First();
            // Act
            var result = TestHelper.ProductService.AddRating(data.Id, -8);

            // Assert
            Assert.AreEqual(false, result);
        }

        [Test]
        public void AddRating_InValid_Product_Empty_Should_Return_False()
        {
            // Arrange

            // Act
            var result = TestHelper.ProductService.AddRating("", 1);

            // Assert
            Assert.AreEqual(false, result);
        }


        [Test]
            public void AddRating_InValid_null_should_return_false()
            {
                // Arrange
                var data = TestHelper.ProductService.GetAllData().First();


                // Act
                var result = TestHelper.ProductService.AddRating(null, 1);

                // Assert
                Assert.AreEqual(false, result);
            }
          

             [Test]
            public void AddRating_InValid_()
            {
                // Arrange

                // Act
                //var result = TestHelper.ProductService.AddRating(null, 1);

                // Assert
                //Assert.AreEqual(false, result);
            }

            // ....

            [Test]
            public void AddRating_Valid_Product_Valid_Rating_Valid_Should_Return_True()
            {
                // Arrange

                // Get the First data item
                var data = TestHelper.ProductService.GetAllData().First();
                var countOriginal = data.Ratings.Length;

                // Act
                var result = TestHelper.ProductService.AddRating(data.Id, 5);
                var dataNewList = TestHelper.ProductService.GetAllData().First();

                // Assert
                Assert.AreEqual(true, result);
                Assert.AreEqual(countOriginal + 1, dataNewList.Ratings.Length);
                Assert.AreEqual(5, dataNewList.Ratings.Last());
            }
        }
        #endregion

        namespace UnitTests.Pages.Product.UpdateDataRating
        {
            public class JsonFileProductServiceTests
            {
                #region TestSetup

                [SetUp]
                public void TestInitialize()
                {
                }

                #endregion TestSetup

                #region UpdateData
                [Test]
                public void UpdateData_InValid_Product_Null_Should_Return_False()
                {
                    // Arrange

                    // Act
                    var result = TestHelper.ProductService.AddRating(null,1);

                    // Assert
                    Assert.AreEqual(false, result);
                }

                [Test]
                public void UpdateData_InValid_()
                {
                    // Arrange

                    // Act
                    //var result = TestHelper.ProductService.AddRating(null, 1);

                    // Assert
                    //Assert.AreEqual(false, result);
                }

                // ....

                [Test]
                public void UpdateData_Valid_Product_Valid_Rating_Valid_Should_Return_True()
                {
                    // Arrange

                    // Get the First data item
                    var data = TestHelper.ProductService.GetAllData().First();
                    var countOriginal = data.Ratings.Length;

                    // Act
                    var result = TestHelper.ProductService.AddRating(data.Id, 5);
                    var dataNewList = TestHelper.ProductService.GetAllData().First();

                    // Assert
                    Assert.AreEqual(true, result);
                    Assert.AreEqual(countOriginal + 1, dataNewList.Ratings.Length);
                    Assert.AreEqual(5, dataNewList.Ratings.Last());
                }
            }
            #endregion

            namespace UnitTests.Pages.Product.GetAllDataRating
            {
                public class JsonFileProductServiceTests
                {
                    #region TestSetup

                    [SetUp]
                    public void TestInitialize()
                    {
                    }

                    #endregion TestSetup

                    #region GetallData
                    [Test]
                    public void GetAllData_InValid_Product_Null_Should_Return_False()
                    {
                        // Arrange

                        // Act
                        var result = TestHelper.ProductService.AddRating(null, 1);

                        // Assert
                        Assert.AreEqual(false, result);
                    }

                    [Test]
                    public void GetAllData_InValid_()
                    {
                        // Arrange

                        // Act
                        //var result = TestHelper.ProductService.AddRating(null, 1);

                        // Assert
                        //Assert.AreEqual(false, result);
                    }

                    // ....

                    [Test]
                    public void GetAllData_Valid_Product_Valid_Rating_Valid_Should_Return_True()
                    {
                        // Arrange

                        // Get the First data item
                        var data = TestHelper.ProductService.GetAllData().First();
                        var countOriginal = data.Ratings.Length;

                        // Act
                        var result = TestHelper.ProductService.AddRating(data.Id,5);
                        var dataNewList = TestHelper.ProductService.GetAllData().First();

                        // Assert
                        Assert.AreEqual(true, result);
                        Assert.AreEqual(countOriginal + 1, dataNewList.Ratings.Length);
                        Assert.AreEqual(5, dataNewList.Ratings.Last());
                    }
                    #endregion








                }
            }
        }
    }