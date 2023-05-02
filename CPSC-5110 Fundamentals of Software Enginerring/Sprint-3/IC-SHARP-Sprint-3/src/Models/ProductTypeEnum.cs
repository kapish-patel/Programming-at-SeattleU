using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ContosoCrafts.WebSite.Models
{
    public enum ProductTypeEnum
    {
        Undefined = 0,
        Amature = 1,
        Antique = 5,
        Collectable = 130,
        Commercial = 55,
    }

    public static class ProductTypeEnumExtensions
    {
        public static string DisplayName(this ProductTypeEnum data)
        {
            return data switch
            {
                ProductTypeEnum.Amature => "Hand Made Items",
                ProductTypeEnum.Antique => "Antiques",
                ProductTypeEnum.Collectable => "Collectables",
                ProductTypeEnum.Commercial => "Commercial goods",
 
                // Default, Unknown
                _ => "",
            };
        }
    }
}