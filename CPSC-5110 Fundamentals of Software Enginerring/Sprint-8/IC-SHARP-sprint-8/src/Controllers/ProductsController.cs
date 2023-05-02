using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;

namespace ContosoCrafts.WebSite.Controllers
{
    /// <summary>
    /// ProductsController Class for an MVC controller
    /// </summary>
    [ApiController]
    [Route("[controller]")]
    public class ProductsController : ControllerBase
    {
        /// <summary>
        /// Product Controller sets ProductService to productService from jsonfileproductService
        /// </summary>
        /// <param name="productService"></param>
        public ProductsController(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //ProductService Variable for getting data from JsonfileProductService 
        public JsonFileProductService ProductService { get; }

        /// <summary>
        /// exposes a IEnumerable that supports a simple iteration over a collection of spcified type
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public IEnumerable<ProductModel> Get()
        {
            return ProductService.GetAllData();
        }

        /// <summary>
        /// Request the rating for the specific ProductID
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPatch]
        public ActionResult Patch([FromBody] RatingRequest request)
        {
            if (ProductService.AddRating(request.ProductId, request.Rating))
                return Ok();
            else
                return BadRequest();
        }

        /// <summary>
        /// RatingRequest class for handeling requests of ratings 
        /// </summary>
        public class RatingRequest
        {
            public string ProductId { get; set; }
            public int Rating { get; set; }
        }
    }
}