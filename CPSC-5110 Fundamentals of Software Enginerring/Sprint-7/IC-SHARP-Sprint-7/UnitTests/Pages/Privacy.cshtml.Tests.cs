using Microsoft.Extensions.Logging;

using NUnit.Framework;

using Moq;

using ContosoCrafts.WebSite.Pages;

namespace UnitTests.Pages.Privacy
{
    /// <summary>
    /// This class is unit test for Privacy.cshtml.cs
    /// </summary>
    public class PrivacyTests
    {
        #region TestSetup
        public static PrivacyModel pageModel;

        /// <summary>
        /// Initializes a test
        /// </summary>
        [SetUp]
        public void TestInitialize()
        {
            //Initializes a mock logger for the model
            var MockLoggerDirect = Mock.Of<ILogger<PrivacyModel>>();

            //Creates new model object
            pageModel = new PrivacyModel(MockLoggerDirect)
            {
                PageContext = TestHelper.PageContext,
                TempData = TestHelper.TempData,
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        ///  This is used to test OnGet method that activity id and request Id should be matching
        /// </summary>
        [Test]
        public void OnGet_Valid_Activity_Set_Should_Return_RequestId()
        {
            // Arrange

            // Act
            pageModel.OnGet();

            // Reset

            // Assert
            Assert.AreEqual(true, pageModel.ModelState.IsValid);
        }

        #endregion OnGet
    }
}