using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace ContosoCrafts.WebSite.Models
{
    /// <summary>
    /// Created a class for ProductModel
    /// </summary>
    public class ProductModel
    {   //This is used to get ID and set ID value
        public string Id { get; set; }
        [Required(ErrorMessage = "Maker is required")]
        //Returns an error message mentioning maker is required
        public string Maker { get; set; }
        [RegularExpression(@"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", ErrorMessage = "Please enter a valid email")]
        [Required(ErrorMessage = "Email is required")]
        //Returns an error message mentioning to enter a valid email
        //Returns an error message mentioning email is required
        public string MakerEmail { get; set; }
        [JsonPropertyName("img")]
        [RegularExpression(@"^(http|ftp|https|www)://([\w+?\.\w+])+([a-zA-Z0-9\~\!\@\#\$\%\^\&\*\(\)_\-\=\+\\\/\?\.\:\;\'\,]*)?$", ErrorMessage = "Please enter a valid image url")]
        //Returns an error message mentioning to enter a valid image url
        //The get method returns the value to Image variable and set method assigns a value to Image variable
        public string Image { get; set; }
        //This is used to get url and set url value
        public string Url { get; set; }
        [StringLength (maximumLength: 33, MinimumLength = 1, ErrorMessage = "The Title should have a length of more than {2} and less than {1}")]
        [Required(ErrorMessage = "Title is required")]
        [RegularExpression(@"^.*[a-zA-Z]", ErrorMessage = "Please enter a valid Title")]
        //Displays messages mentioning the required length,title and to enter a valid title.
        public string Title { get; set; }
        [StringLength(maximumLength: 50, MinimumLength = 2, ErrorMessage = "The description should have a length of more than {2} and less than {1}")]
        [Required(ErrorMessage = "description is required")]
        //The get method returns a value to Description variable and set method assigns a value to Description variable
        //Displays a message mentioning that the description is required.
        public string Description { get; set; }
        //The get method returns a value to the Rating variable and set method assigns a value to the Rating variable
        public int[] Ratings { get; set; }
        /// <summary>
        /// To improve program's readability with a group of constants
        /// </summary>
        public ProductTypeEnum ProductType { get; set; } = ProductTypeEnum.Undefined;
        //Displays the messages mentioning the value to be between 1 & 2 and the price that is required.
        public string Quantity { get; set; }
        [Range (1, 100, ErrorMessage = "Value for {0} must be between {1} and {2}.")]
        [Required(ErrorMessage = "price is required")]
        public int Price { get; set; }
        // Store the Comments entered by the users on this product
        public List<CommentModel> CommentList { get; set; } = new List<CommentModel>();
        public override string ToString() => JsonSerializer.Serialize<ProductModel>(this);


    }
}