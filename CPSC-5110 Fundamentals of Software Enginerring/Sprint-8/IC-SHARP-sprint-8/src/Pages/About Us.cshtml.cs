using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{ 
    /// <summary>
    ///  An abstract class for representing a page
    /// </summary>
    public class About_UsModel : PageModel
    {
        /// <summary>
        /// Generic interface for logging where c ategoryname is derived from the specified About_UsModel type name.
        /// Enables activation of a named ILogger from dependency injection.
        /// </summary>
        private readonly ILogger<About_UsModel> _logger;

        public About_UsModel(ILogger<About_UsModel> logger)
        {
            _logger = logger;
        }
        public void OnGet()
        {
        }
    }
}
