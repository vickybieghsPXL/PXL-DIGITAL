using System;

namespace PixelPass
{
    public class AccountInfo
    {
        public AccountInfo(string title, string username, string password, string notes, DateTime expiration)
        {
            Title = title;
            Username = username;
            Password = password;
            Notes = notes;
            Expiration = expiration;
        }

        public string Title { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Notes { get; set; }
        public DateTime Expiration { get; set; }

        public bool IsExpired => (Expiration < DateTime.Now);

       
        public override string ToString()
        {
            if (IsExpired)
            {
                return $"{Title} (expired)";
            }
            return Title;
        }
    }
}
