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
    /// Chunhai Yang
    /// Kapish Patel
    /// Sriram Vishnu Krishna
    /// Vidhi Rathod
    /// </summary>
    ///

    // This is used to render data to index.cshtml
    public class IndexModel : PageModel
    {
        //Hi Mike
        private readonly ILogger<IndexModel> _logger;

        // Initializes logger and productService
        public IndexModel(ILogger<IndexModel> logger,
            JsonFileProductService productService)
        {
            _logger = logger;
            ProductService = productService;
        }

        public JsonFileProductService ProductService { get; }
        public IEnumerable<ProductModel> Products { get; private set; }

        //To store the search string from the search bar
        [BindProperty(SupportsGet = true)]
        public string SearchString { get; set; }

        // This is used to get all of the data
        public IActionResult OnGet(string SearchString)
        {
            if (string.IsNullOrEmpty(SearchString))
            {
                Products = ProductService.GetAllData();
                return Page();
            }
            else
            {
                Products = ProductService.GetAllData().Where(m => m.Title.Equals(SearchString));
                if(Products.Count() == 0)
                {
                    Products = ProductService.GetAllData();
                    return Page();
                }

                return RedirectToPage("./Product/Read", new { id = Products.First().Id });
            }
        }
    }
}