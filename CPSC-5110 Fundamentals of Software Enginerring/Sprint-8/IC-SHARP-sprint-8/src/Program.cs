using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
namespace ContosoCrafts.WebSite
{
    /// <summary>
    /// Class Program contains main method and create host
    /// </summary>
    public class Program 
    {
        /// <summary>
        /// main method create ost with createhost builder
        /// </summary>
        /// <param name="args"></param>
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        /// <summary>
        /// method CreateHostBuilder to create and configure a builder object
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
