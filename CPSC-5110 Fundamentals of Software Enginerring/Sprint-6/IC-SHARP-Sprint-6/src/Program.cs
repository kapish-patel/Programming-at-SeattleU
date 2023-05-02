using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
namespace ContosoCrafts.WebSite
{    ///Calls build and run methods on the builder objects
    public class Program 
    { 
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }
        ///Created a method called CreateHostBuilder to create and configure a builder object
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
