using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    /// <summary>
    /// DeleteModel class uses JsonFileProductServices to Delete data 
    /// </summary>
    public class DeleteModel : PageModel
    {
        //using services from Jsonproductfileservices as ProductService 
        public JsonFileProductService ProductService { get; }

        /// <summary>
        /// Delete mode to delete a product as a model 
        /// </summary>
        /// <param name="productService"></param>
        public DeleteModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //binding properties of product model and the productModel
        [BindProperty]
        public ProductModel Product { get; set; }

        /// <summary>
        /// get the product with id passed in onGet
        /// </summary>
        /// <param name="id"></param>
        public void OnGet(string id)
        {
            Product = ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(id));
        }

        /// <summary>
        /// OnPost check if it is valid or not, delete data and return to index page
        /// </summary>
        /// <returns></returns>
        public IActionResult OnPost()
        {
            ProductService.DeleteData(Product.Id);
            return RedirectToPage("./Index");
        }
    }
}
