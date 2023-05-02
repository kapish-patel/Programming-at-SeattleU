using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    /// <summary>
    /// ReadModel class uses JsonFileProductServices to Read data
    /// </summary>
    public class ReadModel : PageModel
    {
        //using services from Jsonproductfileservices as ProductService
        public JsonFileProductService ProductService { get; set; }

        /// <summary>
        /// Default Constructor
        /// </summary>
        /// <param name="productService"></param>
        public ReadModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        // Product variable as ProductModel
        public ProductModel Product;

        /// <summary>
        ///  REST get the product with id passed in onGet
        /// </summary>
        /// <param name="id"></param>
        public void OnGet(string id)
        {
            Product = ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(id));
        }
    }
}
