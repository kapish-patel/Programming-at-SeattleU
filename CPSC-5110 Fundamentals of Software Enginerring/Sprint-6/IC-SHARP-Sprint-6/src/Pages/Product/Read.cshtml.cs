using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    // This is used to render data to read.cshtml
    public class ReadModel : PageModel
    {
        public JsonFileProductService ProductService { get; set; }
        public ReadModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        public ProductModel Product;
        // This is used to get corresponding product with matching id
        public void OnGet(string id)
        {
            Product = ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(id));
        }
    }
}
