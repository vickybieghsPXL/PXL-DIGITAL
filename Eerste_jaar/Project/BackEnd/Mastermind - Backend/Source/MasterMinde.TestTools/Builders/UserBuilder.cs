using System;
using MasterMind.Data.DomainClasses;

namespace MasterMind.TestTools.Builders
{
    public class UserBuilder
    {
        private readonly User _user;

        public UserBuilder()
        {
            _user = new User
            {
                Email = Guid.NewGuid().ToString(),
                NickName = Guid.NewGuid().ToString(),
                UserName = Guid.NewGuid().ToString(),
                PasswordHash = Guid.NewGuid().ToString()
            };
        }

        public UserBuilder WithId()
        {
            _user.Id = Guid.NewGuid();
            return this;
        }

        public User Build()
        {
            return _user;
        }
    }
}