using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using ContosoCrafts.WebSite.Services;
using ContosoCrafts.WebSite.Models;
namespace ContosoCrafts.WebSite.Pages.Product
{

    public class CreateModel : PageModel
    {
        //using services from Jsonproductfileservices 
        public JsonFileProductService ProductService { get; }

        //CreateModel to make a mode and save data into model
        public CreateModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //Product for storing product
        public ProductModel Product;
        
        //onGet to pass the flow to update page and add the data from update page
        public IActionResult OnGet()
        {
            Product = ProductService.CreateData();

            return RedirectToPage("./Modify", new { Id = Product.Id });
        }
    }
}
