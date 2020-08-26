using System;

namespace MasterMind.Data.DomainClasses
{
    public interface IPlayer
    {
        Guid Id { get; set; }
        string NickName { get; set; }
        bool IsHuman { get; }
    }
}