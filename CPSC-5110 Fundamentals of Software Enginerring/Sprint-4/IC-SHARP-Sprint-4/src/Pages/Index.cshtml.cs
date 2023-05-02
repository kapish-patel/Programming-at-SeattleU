using System.Collections.Generic;

using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

using ContosoCrafts.WebSite.Models;
using ContosoCrafts.WebSite.Services;

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

        // This is used to get all of the data
        public void OnGet()
        {
            Products = ProductService.GetAllData();
        }
    }
}