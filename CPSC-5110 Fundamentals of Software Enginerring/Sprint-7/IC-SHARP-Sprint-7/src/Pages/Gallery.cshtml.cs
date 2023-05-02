using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    /// <summary>
    /// An abstract class for representing a page
    /// </summary>
    public class GalleryModel : PageModel
    {
        /// <summary>
        /// Generic interface for logging where categoryname is derived from the specified GalleryModel type name.
        ///  Enables activation of a named ILogger from dependency injection.
        /// </summary>
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
