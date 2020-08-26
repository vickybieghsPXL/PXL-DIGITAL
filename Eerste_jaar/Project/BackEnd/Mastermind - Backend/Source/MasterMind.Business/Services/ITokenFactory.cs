using System.Collections.Generic;
using System.Security.Claims;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Business.Services
{
    public interface ITokenFactory
    {
        string CreateToken(User user, IList<Claim> currentUserClaims);
    }
}
