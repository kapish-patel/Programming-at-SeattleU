using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    public class TermsModel : PageModel
    {
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
