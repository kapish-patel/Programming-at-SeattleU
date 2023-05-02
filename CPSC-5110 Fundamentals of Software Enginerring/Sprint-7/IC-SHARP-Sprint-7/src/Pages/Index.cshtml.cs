using System.Collections.Generic;

using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System;

namespace ContosoCrafts.WebSite.Pages
{
   /// <summary>
   /// Abstract class representing a page
   /// </summary>
    public class IndexModel : PageModel
    {
        /// <summary>
        /// Generic interface for logging where categoryname is derived from the specified IndexModeltype name.
        ///  Enables activation of a named ILogger from dependency injection.
        /// </summary>
        private readonly ILogger<IndexModel> _logger;

        /// <summary>
        /// Initializes logger and productService
        /// </summary>
        /// <param name="logger"></param>
        /// <param name="productService"></param>
        public IndexModel(ILogger<IndexModel> logger,
            JsonFileProductService productService)
        {
            _logger = logger;
            ProductService = productService;
        }
        //get method returns a value to ProductService
        public JsonFileProductService ProductService { get; }
        //Exposes the enumerator,that supports a single iteration over a collection of a specified type.
        public IEnumerable<ProductModel> Products { get; private set; }

        //To store the search string from the search bar
        [BindProperty(SupportsGet = true)]
        public string SearchString { get; set; }

        /// <summary>
        /// This is used to get all of the data
        /// </summary>
        /// <param name="SearchString"></param>
        /// <returns></returns>
        public IActionResult OnGet(string SearchString)
        {

            if(!string.IsNullOrEmpty(SearchString))
            {
                Products = ProductService.GetAllData().Where(m => m.Title.ToLower().StartsWith(SearchString.ToLower()));
                if(Products.Count() == 0)
                {
                    Products = ProductService.GetAllData();
                    return Page();
                }

                return RedirectToPage("./Product/Read", new { id = Products.First().Id });
            }

            Products = ProductService.GetAllData();
            return Page();
        }
    }
}