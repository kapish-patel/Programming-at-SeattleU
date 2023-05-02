using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    /// <summary>
    /// An abstract class for representing a page.
    /// </summary>
    public class Contact_UsModel : PageModel
    {/// <summary>
     /// Generic interface for logging where categoryname is derived from the specified Contact_UsModel type name.
     /// Enables activation of a named ILogger from dependency injection.
     /// </summary>
        private readonly ILogger<Contact_UsModel> _logger;

        public Contact_UsModel(ILogger<Contact_UsModel> logger)
        {
            _logger = logger;
        }
        public void OnGet()
        {
        }
    }
}
