using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    /// <summary>
    /// Abstract class for representing a page
    /// </summary>
    public class PrivacyModel : PageModel
    {
        /// <summary>
        /// Generic interface for logging where categoryname is derived from the specified PrivacyModeltype name.
        /// Enables activation of a named ILogger from dependency injection.
        /// </summary>
        private readonly ILogger<PrivacyModel> _logger;

        public PrivacyModel(ILogger<PrivacyModel> logger)
        {
            _logger = logger;
        }
        
        public void OnGet()
        {
        }
    }
}