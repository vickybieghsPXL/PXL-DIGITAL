using System.Net;
using System.Threading.Tasks;
using MasterMind.Api.Models;
using MasterMind.Business.Services;
using MasterMind.Data.DomainClasses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace MasterMind.Api.Controllers
{
    //DO NOT TOUCH THIS FILE!!
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly UserManager<User> _userManager;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly ITokenFactory _tokenFactory;

        public AuthenticationController(UserManager<User> userManager,
            IPasswordHasher<User> passwordHasher,
            ITokenFactory tokenFactory)
        {
            _userManager = userManager;
            _passwordHasher = passwordHasher;
            _tokenFactory = tokenFactory;
        }

        /// <summary>
        /// Registers a new user in the database.
        /// </summary>
        [HttpPost("register")]
        [AllowAnonymous]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> Register([FromBody] RegisterModel model)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var user = new User
            {
                UserName = model.Email,
                Email = model.Email,
                NickName = model.NickName
            };

            var result = await _userManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {
                return Ok();
            }

            //Send the errors that Identity reported in the response
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(error.Code, error.Description);
            }
            return BadRequest(ModelState);
        }

        /// <summary>
        /// Returns an object containing a (bearer) token that will be valid for 60 minutes.
        /// The token should be added in the Authorization header of each http request for which the user must be authenticated.
        /// The Id and NickName of the player are also included in the object.
        /// <example>Authorization bearer [token]</example>
        /// </summary>
        [HttpPost("token")]
        [AllowAnonymous]
        [ProducesResponseType(typeof(AccessPassModel), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.Unauthorized)]
        public async Task<IActionResult> CreateToken([FromBody] LoginModel model)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var user = await _userManager.FindByNameAsync(model.Email);
            if (user == null)
            {
                return Unauthorized();
            }

            if (_passwordHasher.VerifyHashedPassword(user, user.PasswordHash, model.Password) != PasswordVerificationResult.Success)
            {
                return Unauthorized();
            }

            var currentClaims = await _userManager.GetClaimsAsync(user);
            var accessPass = new AccessPassModel
            {
                Token = _tokenFactory.CreateToken(user, currentClaims),
                Player = new PlayerModel
                {
                    Id = user.Id,
                    NickName = user.NickName
                }
            };
            return Ok(accessPass);
        }

    }
}