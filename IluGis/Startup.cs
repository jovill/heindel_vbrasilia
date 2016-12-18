using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IluGis.Startup))]
namespace IluGis
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
