using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    /// <summary>
    /// ModifyModel class uses JsonFileProductServices to Modify data 
    /// </summary>
    public class ModifyModel : PageModel
    {
        //using services from Jsonproductfileservices as ProductService 
        public JsonFileProductService ProductService { get; set; }

        /// <summary>
        /// Default constructor 
        /// </summary>
        /// <param name="productService"></param>
        public ModifyModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        //binding property to product and ProductModel
        [BindProperty]
        public ProductModel Product { get; set; }

        /// <summary>
        /// REST get the product with id passed in onGet
        /// </summary>
        /// <param name="id"></param>
        public void OnGet(string id)
        {
            Product = ProductService.GetAllData().FirstOrDefault(m => m.Id.Equals(id));
        }

        /// <summary>
        /// REST onPost 
        /// update data in json file using UpdateData() 
        /// redirect to /index if successfully updated 
        /// </summary>
        /// <returns></returns>
        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }
            ProductService.UpdateData(Product);

            return RedirectToPage("./Index");
        }
    }
}