using System.Linq;

using Microsoft.AspNetCore.Mvc;

using NUnit.Framework;

using ContosoCrafts.WebSite.Models;
  
namespace UnitTests.Pages.Product.AddRating
{
    /// <summary>
    /// To check UnitTests for AddRating 
    /// </summary>
    public class JsonFileProductServiceTests
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion TestSetup

        #region AddRating
        /// <summary>
        /// Passes three as the rating to return true
        /// </summary>
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

        /// <summary>
        /// Passes two as the rating to return true
        /// </summary>
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

        /// <summary>
        /// Passes an Invalid rating to return false
        /// </summary>
        [Test]
        public void AddRating_InValid_ProductID_Incorrect_Should_Return_False()
        {
            // Arrange

            // Act
            var result = TestHelper.ProductService.AddRating("Welcome", 1);

            // Assert
            Assert.AreEqual(false, result);
        }

        /// <summary>
        /// Passes a rating that is more than five to return false
        /// </summary>
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

        /// <summary>
        /// Passes a rating less than three to return false
        /// </summary>
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

        /// <summary>
        /// Passes a rating less than zero to return false
        /// </summary>
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

        /// <summary>
        /// Passes an empty string to return false
        /// </summary>
        [Test]
        public void AddRating_InValid_Product_Empty_Should_Return_False()
        {
            // Arrange

            // Act
            var result = TestHelper.ProductService.AddRating("", 1);

            // Assert
            Assert.AreEqual(false, result);
        }

        /// <summary>
        /// Passes null to return false
        /// </summary>
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

        /// <summary>
        /// passes an valid rating to return true
        /// </summary>
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
        #endregion
    }
}


namespace UnitTests.Pages.Product.UpdateDataRating
{
    /// <summary>
    /// ///To check UnitTests for UpdateData
    /// </summary>
    public class JsonFileProductServiceTests
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion

        #region UpdateData
        /// <summary>
        /// Method returns null as the result
        /// </summary>
        [Test]
        public void UpdateData_Null_Product_Should_Return_Null()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().First();
            data.Id = "12";

            // Act
            var result = TestHelper.ProductService.UpdateData(data);

            // Assert
            Assert.AreEqual(null, result);
        }

        /// <summary>
        /// Passes rating more than five to return false
        /// </summary>
        [Test]
        public void UpdateData_Product_Rate_more_five_Should_Return_False()
        {
            // Arrange
            var data = TestHelper.ProductService.GetAllData().First();

            // Act
            var result = TestHelper.ProductService.AddRating(data.Id, 6);

            // Assert
            Assert.AreEqual(false, result);
        }

        /// <summary>
        /// Passes a valid rating to return true
        /// </summary>
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
        #endregion
    }
}


namespace UnitTests.Pages.Product.GetAllDataRating
{
    /// <summary>
    /// To check the UnitTests for GetAllData
    /// </summary>
    public class JsonFileProductServiceTests
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion TestSetup

        #region GetallData
        /// <summary>
        /// Passes null to return False
        /// </summary>
        [Test]
        public void GetAllData_InValid_Product_Null_Should_Return_False()
        {
            // Arrange

            // Act
            var result = TestHelper.ProductService.AddRating(null, 1);

            // Assert
            Assert.AreEqual(false, result);
        }

        /// <summary>
        /// Passes a valid rating to return true
        /// </summary>
        [Test]
        public void GetAllData_Valid_Product_Valid_Rating_Valid_Should_Return_True()
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
        #endregion

    }
}

namespace UnitTests.Pages.Product.CreateDataRating
{
    /// <summary>
    /// To check the UnitTests for CreateDataRating 
    /// </summary>
    public class JsonFileProductServiceTests
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion TestSetup

        #region CreateData
        /// <summary>
        /// // Used to test CreateData function in JsonFileProductService.cs. Expected return true
        /// </summary>
        [Test]
        public void CreateData_Create_Valid_Age_Should_Return_True()
        {
            // Arrange

            // Act
            var Age = "32";
            int IntegerAge;
            var ValidAge = int.TryParse(Age, out IntegerAge);

            // Assert
            Assert.AreEqual(true, ValidAge);
        }
        #endregion

        #region SaveData
        /// <summary>
        /// Used to test SaveData function in JsonFileProductService.cs. Expected return false
        /// </summary>
        [Test]
        public void SaveData_Invalid_Age_Should_Return_False()
        {
            // Arrange

            // Act
            var Age = "xyz";
            var InvalidAge = int.TryParse(Age, out int n);

            // Assert
            Assert.AreEqual(false, InvalidAge);
        }

        /// <summary>
        /// Used to test SaveData function in JsonFileProductService.cs. Expected return True
        /// </summary>
        [Test]
        public void SaveData_Valid_Age_Should_Return_True()
        {
            // Arrange

            // Act
            var Age = "20";
            var ValidAge = int.TryParse(Age, out int n);

            // Assert
            Assert.AreEqual(true, ValidAge);
        }
        #endregion
    }
}

namespace UnitTests.Pages.Product.DeleteData
{
    public class JsonFileProductServiceTests
    {
        #region TestSetup

        [SetUp]
        public void TestInitialize()
        {
        }

        #endregion TestSetup

        #region DeleteData
        /// <summary>
        /// Used to test SaveData function in JsonFileProductService.cs. Expected return Data
        /// </summary>
        [Test]
        public void DeleteData_Valid_Id_Should_Return_Data()
        {
            // Arrange

            // Act
            var Id = "4";
            var result = TestHelper.ProductService.DeleteData(Id);
            var data = TestHelper.ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(Id));

            // Assert
            Assert.AreEqual(null, data);
        }
        #endregion
    }
}
           