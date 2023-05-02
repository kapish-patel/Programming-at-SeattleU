using System.Collections.Generic;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using System.Linq;

namespace ContosoCrafts.WebSite.Pages.Product
{
    /// <summary>
    /// Index Page will return all the data to show the user
    /// </summary>
    public class IndexModel : PageModel
    {
        /// <summary>
        /// Default Constructor
        /// </summary>
        /// <param name="productService"></param>
        public IndexModel(JsonFileProductService productService)
        {
            ProductService = productService;
        }

        // Data Service
        public JsonFileProductService ProductService { get; }

        //To store the search string from the search bar
        [BindProperty( SupportsGet = true)]
        public string SearchString { get; set; }

        // Collection of the Data
        public IEnumerable<ProductModel> Products { get; private set; }

        /// <summary>
        /// REST OnGet
        /// Return all the data if search string is empty
        /// else returns only list of services starting with the search string
        /// </summary>
        public void OnGet(string SearchString)
        {
            if (string.IsNullOrEmpty(SearchString))
            {
                Products = ProductService.GetAllData();
            }
            else
            {
                Products = ProductService.GetAllData().Where(m => m.Title.StartsWith(SearchString));
            }
        }
    }
}