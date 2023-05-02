using System.Diagnostics;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace ContosoCrafts.WebSite.Pages
{
    /// <summary>
    /// An Abstract class for representing a page
    /// </summary>
    
    //This is used to render data or message onto error.cshtml
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]   
    public class ErrorModel : PageModel
    {
        public string RequestId { get; set; }
        
        /// <summary>
        /// Indicates whether the specified string is a null or an empty string.
        /// </summary>
        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);

        /// <summary>
        /// Generic interface for logging where categoryname is derived from the specified ErrorModel type name.
        /// Enables activation of a named ILogger from dependency injection.
        /// </summary>
        private readonly ILogger<ErrorModel> _logger;

        public ErrorModel(ILogger<ErrorModel> logger)
        {
            _logger = logger;
        }
        // This is used to get request id
        public void OnGet()
        {
            RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier;
        }
    }
}