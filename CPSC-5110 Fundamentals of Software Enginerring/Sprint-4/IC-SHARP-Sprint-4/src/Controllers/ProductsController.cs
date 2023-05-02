using System.Collections.Generic;

using Microsoft.AspNetCore.Mvc;

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;

namespace ContosoCrafts.WebSite.Controllers
{
    [ApiController]
    [Route("[controller]")]
   
    ///Class for an MVC controller without view support
    public class ProductsController : ControllerBase
    {
        public ProductsController(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        public JsonFileProductService ProductService { get; }

        [HttpGet]
        // exposes a numerator that supports a simple iteration over a collection of spcified type
        public IEnumerable<ProductModel> Get()
        {
            return ProductService.GetAllData();
        }

        [HttpPatch]
        ///Request the rating for the specific ProductID
        public ActionResult Patch([FromBody] RatingRequest request)
        {
            if (ProductService.AddRating(request.ProductId, request.Rating))
                return Ok();
            else
                return BadRequest();
        }

        public class RatingRequest
        {
            public string ProductId { get; set; }
            public int Rating { get; set; }
        }
    }
}