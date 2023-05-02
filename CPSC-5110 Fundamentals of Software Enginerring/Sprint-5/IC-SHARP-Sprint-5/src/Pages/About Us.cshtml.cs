using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    public class About_UsModel : PageModel
    {

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
