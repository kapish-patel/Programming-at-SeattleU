using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ContosoCrafts.WebSite.Services;
using ContosoCrafts.WebSite.Models;

namespace ContosoCrafts.WebSite.Pages.Product
{
    /// <summary>
    /// CreateModel class uses JsonFileProductServices to create data 
    /// </summary>
    public class CreateModel : PageModel
    {

        //using services from Jsonproductfileservices as ProductService
        public JsonFileProductService ProductService { get; }

        /// <summary>
        /// CreateModel to make a model and save data into model
        /// </summary>
        /// <param name="productService"></param>
        public CreateModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //Product for storing product as ProductModel
        public ProductModel Product;

        /// <summary>
        /// OnPost submit Data to CeateData function
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        public IActionResult OnPost(ProductModel product)
        {
            ProductService.CreateData(product);
            return RedirectToPage("./Index");
        }
    }
}
