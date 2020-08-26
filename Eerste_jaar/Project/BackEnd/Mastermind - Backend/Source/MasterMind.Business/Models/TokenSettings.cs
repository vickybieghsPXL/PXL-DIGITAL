namespace MasterMind.Business.Models
{
    //DO NOT TOUCH THIS FILE!!
    public class TokenSettings
    {
        public string Key { get; set; }
        public string Issuer { get; set; }
        public string Audience { get; set; }
        public int ExpirationTimeInMinutes { get; set; }
    }
}