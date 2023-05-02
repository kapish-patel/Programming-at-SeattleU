using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    public class Contact_UsModel : PageModel
    {
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
