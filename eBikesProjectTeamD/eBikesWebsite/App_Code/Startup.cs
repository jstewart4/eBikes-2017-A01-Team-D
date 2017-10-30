using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(eBikesWebsite.Startup))]
namespace eBikesWebsite
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
