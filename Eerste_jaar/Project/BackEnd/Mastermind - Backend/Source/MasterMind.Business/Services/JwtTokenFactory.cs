using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using MasterMind.Business.Models;
using MasterMind.Data.DomainClasses;
using Microsoft.IdentityModel.Tokens;
using JwtRegisteredClaimNames = Microsoft.IdentityModel.JsonWebTokens.JwtRegisteredClaimNames;

namespace MasterMind.Business.Services
{
    //DO NOT TOUCH THIS FILE!!
    public class JwtTokenFactory : ITokenFactory
    {
        private readonly TokenSettings _settings;

        public JwtTokenFactory(TokenSettings settings)
        {
            _settings = settings;
        }

        public string CreateToken(User user, IList<Claim> currentUserClaims)
        {
            var allClaims = new[]
            {
                new Claim(JwtRegisteredClaimNames.NameId, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
            }.Union(currentUserClaims).ToList();

            var keyBytes = Encoding.UTF8.GetBytes(_settings.Key);
            var symmetricSecurityKey = new SymmetricSecurityKey(keyBytes);
            var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);

            var jwtSecurityToken = new JwtSecurityToken(
                issuer: _settings.Issuer,
                audience: _settings.Audience,
                claims: allClaims,
                expires: DateTime.UtcNow.AddMinutes(_settings.ExpirationTimeInMinutes),
                signingCredentials: signingCredentials);

            return new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
        }
    }
}