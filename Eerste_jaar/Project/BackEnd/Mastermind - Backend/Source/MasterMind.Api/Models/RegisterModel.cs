using System.ComponentModel.DataAnnotations;

namespace MasterMind.Api.Models
{
    public class RegisterModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        [MinLength(6)]
        public string Password { get; set; }

        [Required]
        public string NickName { get; set; }
    }
}
