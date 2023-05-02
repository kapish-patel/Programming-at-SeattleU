using System.Text.Json;
using System.Text.Json.Serialization;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace ContosoCrafts.WebSite.Models
{
    public class ProductModel
    {
        public string Id { get; set; }
        [Required(ErrorMessage = "Maker is required")]
        public string Maker { get; set; }

        [RegularExpression(@"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", ErrorMessage = "Please enter a valid email")]
        public string MakerEmail { get; set; }

        [JsonPropertyName("img")]
        [RegularExpression(@"^(http|ftp|https|www)://([\w+?\.\w+])+([a-zA-Z0-9\~\!\@\#\$\%\^\&\*\(\)_\-\=\+\\\/\?\.\:\;\'\,]*)?$", ErrorMessage = "Please enter a valid image uri")]
        public string Image { get; set; }

        public string Url { get; set; }
        
        [StringLength (maximumLength: 33, MinimumLength = 1, ErrorMessage = "The Title should have a length of more than {2} and less than {1}")]
        [Required(ErrorMessage = "Title is required")]
        [RegularExpression(@"^.*[a-zA-Z]", ErrorMessage = "Please enter a valid Title")]
        public string Title { get; set; }

        [StringLength(maximumLength: 50, MinimumLength = 2, ErrorMessage = "The description should have a length of more than {2} and less than {1}")]
        [Required(ErrorMessage = "description is required")]
        public string Description { get; set; }

        public int[] Ratings { get; set; }

        public ProductTypeEnum ProductType { get; set; } = ProductTypeEnum.Undefined;

        public string Quantity { get; set; }

        [Range (1, 100, ErrorMessage = "Value for {0} must be between {1} and {2}.")]
        [Required(ErrorMessage = "price is required")]
        public int Price { get; set; }

        // Store the Comments entered by the users on this product
        public List<CommentModel> CommentList { get; set; } = new List<CommentModel>();

        public override string ToString() => JsonSerializer.Serialize<ProductModel>(this);


    }
}