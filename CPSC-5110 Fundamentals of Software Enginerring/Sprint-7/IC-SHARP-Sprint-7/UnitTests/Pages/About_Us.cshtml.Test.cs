﻿using ContosoCrafts.WebSite.Pages;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnitTests.Pages
{
    /// <summary>
    /// This class is unit test for AboutUs.cshtml.cs
    /// </summary>
    public class About_UsTest
    {   
        #region TestSetup
        public static About_UsModel pageModel;

        /// <summary>
        /// Initializes test for AboutUs
        /// </summary>
        [SetUp]
        public void TestInitialize()
        {
            //Initializes a mock logger for the model
            var MockLoggerDirect = Mock.Of<ILogger<About_UsModel>>();
            
            //Creates a new object of About Us Model
            pageModel = new About_UsModel(MockLoggerDirect)
            {
                PageContext = TestHelper.PageContext,
                TempData = TestHelper.TempData,
            };
        }

        #endregion TestSetup

        #region OnGet
        /// <summary>
        /// This is used to test OnGet method that activity id and request Id should be matching
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
