using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    // This is used to render data to privacy.cshtml
    public class GalleryModel : PageModel
    {
        private readonly ILogger<GalleryModel> _logger;

        public GalleryModel(ILogger<GalleryModel> logger)
        {
            _logger = logger;
        }
        
        public void OnGet()
        {
        }
    }
}
