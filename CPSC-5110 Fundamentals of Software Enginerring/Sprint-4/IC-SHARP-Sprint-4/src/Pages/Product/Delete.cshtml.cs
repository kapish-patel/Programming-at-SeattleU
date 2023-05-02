using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    public class DeleteModel : PageModel
    {
        //Product service from Jsonfileproductservice
        public JsonFileProductService ProductService { get; }

        //Delete mode to delete a product as a model 
        public DeleteModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //binding properties of product model and the product
        [BindProperty]
        public ProductModel Product { get; set; }

        //get the product with id passed
        public void OnGet(string id)
        {
            Product = ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(id));
        }

        //OnPost check if it is valid or not, delete data and return to index page
        public IActionResult OnPost()
        {
            if(!ModelState.IsValid)
            {
                return Page();
            }

            ProductService.DeleteData(Product.Id);
            return RedirectToPage("./Index");
        }
    }
}
