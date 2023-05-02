using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{ 
 /// <summary>
 /// Abstract class representing a page
 /// </summary>
    public class TermsModel : PageModel
    {/// <summary>
     /// Generic interface for logging where categoryname is derived from the specified TermsModeltype name.
     /// Enables activation of a named ILogger from dependency injection.
     /// </summary>
        private readonly ILogger<TermsModel> _logger;

        public TermsModel(ILogger<TermsModel> logger)
        {
            _logger = logger;
        }
        public void OnGet()
        {
        }
    }
}