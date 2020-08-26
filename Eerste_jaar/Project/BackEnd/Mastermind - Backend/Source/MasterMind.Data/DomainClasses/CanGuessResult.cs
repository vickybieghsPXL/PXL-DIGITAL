namespace MasterMind.Data.DomainClasses
{
    public enum CanGuessResult
    {
        Ok = 1,
        MustWaitOnOthers = 500, 
        MaximumReached = 501,
        RoundNotStarted = 502,
        NotAllowedDueToGameStatus = 503 //E.g. the game is already in a newer round.
    }
}