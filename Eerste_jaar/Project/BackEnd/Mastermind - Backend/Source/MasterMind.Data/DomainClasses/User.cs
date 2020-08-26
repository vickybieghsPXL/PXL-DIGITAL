using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace MasterMind.Data.DomainClasses
{
    public class User : IdentityUser<Guid>, IPlayer
    {
        [Required]
        public string NickName { get; set; }

        [NotMapped]
        public bool IsHuman
        {
            get { return true; }
        }
    }
}
