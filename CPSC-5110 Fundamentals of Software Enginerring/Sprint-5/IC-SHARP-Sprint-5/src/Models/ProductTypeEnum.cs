using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ContosoCrafts.WebSite.Models
{
   /// <summary>
   /// Method to improve program's readablity with a group of constants
   /// </summary>
    public enum ProductTypeEnum
    { 
        Undefined = 0,
        Health = 1,
        Household = 2,
        Food = 3,
        Commercial = 4,
    }


    public static class ProductTypeEnumExtensions
    {
        /// <summary>
        /// Extending string type
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string DisplayName(this ProductTypeEnum data)
        {
            return data switch
            {
                ProductTypeEnum.Health => "Health Services",
                ProductTypeEnum.Household => "Household Services",
                ProductTypeEnum.Food => "Food Services",
                ProductTypeEnum.Commercial => "Commercial Services",
 
                // Default, Unknown
                _ => "",
            };
        }
    }
}