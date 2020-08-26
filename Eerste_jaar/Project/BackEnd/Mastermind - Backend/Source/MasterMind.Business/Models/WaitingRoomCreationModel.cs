using System.ComponentModel.DataAnnotations;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Business.Models
{
    public class WaitingRoomCreationModel
    {
        [Required, MinLength(3)]
        public string Name { get; set; }

        [Required]
        public GameSettings GameSettings { get; set; }
    }
}