using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MasterMind.Api.Controllers
{
    [Route("")]
    [AllowAnonymous]
    public class HomeController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return RedirectPermanent("~/swagger");
        }
    }
}