using System;
using MasterMind.Data.DomainClasses;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using System.Threading.Tasks;
using MasterMind.Api.Models;
using MasterMind.Business.Services;
using MasterMind.Data;
using Microsoft.AspNetCore.Identity;

namespace MasterMind.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GamesController : ControllerBase
    {
        private readonly IGameService _gameService;
        private readonly UserManager<User> _userManager;

        public GamesController(IGameService gameService, UserManager<User> userManager)
        {
            _gameService = gameService;
            _userManager = userManager;
        }

        /// <summary>
        /// Starts a new game using waiting room info
        /// </summary>
        [HttpPost("")]
        [ProducesResponseType(typeof(Game), (int)HttpStatusCode.Created)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public IActionResult StartNewGame(Guid waitingRoomId)
        {
            try
            {
                var game = _gameService.StartGameForRoom(waitingRoomId);
                return CreatedAtAction(nameof(GetGame), new {id = game.Id}, game);
            }
            catch (DataNotFoundException)
            {
                ModelState.AddModelError("waitingRoomNotFound", $"Could not find a waiting room with id {waitingRoomId}");
            }
            catch (ApplicationException applicationException)
            {
                ModelState.AddModelError("applicationException", applicationException.Message);
            }
            return BadRequest(ModelState);
        }

        /// <summary>
        /// Returns the game with a matching id.
        /// </summary>
        /// <param name="id">The identifier of the game</param>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(Game),(int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public IActionResult GetGame(Guid id)
        {
            try
            {
                var game = _gameService.GetGameById(id);
                return Ok(game);
            }
            catch (DataNotFoundException)
            {
                return NotFound();
            }
        }

        /// <summary>
        /// Checks if it is possible for the logged in player to do a guess.
        /// Ceveral codes can be returned 
        /// 1 (Ok): the player can do a guess.
        /// 500 (MustWaitOnOthers): the player must wait on other players to do a guess.
        /// 501 (MaximumReached): the player has made the maximum allowed guesses for the round. The player should wait for the round to start
        /// 502 (RoundNotStarted): the round is not yet started.
        /// 503 (NotAllowedDueToGameStatus): the state of the game prohibits the guess. E.g. the game could be in a new round. 
        /// </summary>
        /// <param name="id">The identifier of the game</param>
        /// <param name="roundNumber">The number of the round the player wants to make a guess for.</param>
        [HttpGet("{id}/canguess/forround/{roundNumber}")]
        [ProducesResponseType(typeof(CanGuessResult), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> CanGuessCode(Guid id, int roundNumber)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            try
            {
                var canGuess = _gameService.CanGuessCode(id, currentUser, roundNumber);
                return Ok(canGuess);
            }
            catch (DataNotFoundException)
            {
                ModelState.AddModelError("gameRoomNotFound", $"Could not find a game with id {id}");
            }
            return BadRequest(ModelState);
        }

        /// <summary>
        /// Executes a guess for the logged in player in the current round of the game.
        /// An object is returned that contains the amount of colors on the exact correct position 
        /// and the amount of colors that are correct but on the wrong position.
        /// </summary>
        /// <param name="id">The identifier of the game</param>
        /// <param name="model">The colors of the guess</param>
        [HttpPost("{id}/guess")]
        [ProducesResponseType((typeof(GuessResult)),(int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> GuessCode(Guid id, GuessModel model)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            try
            {
                var guess = _gameService.GuessCode(id, model.Colors, currentUser);
                return Ok(guess);
            }
            catch (DataNotFoundException)
            {
                ModelState.AddModelError("gameRoomNotFound", $"Could not find a game with id {id}");
            }
            catch (ApplicationException applicationException)
            {
                ModelState.AddModelError("applicationException", applicationException.Message);
            }
            return BadRequest(ModelState);
        }

        /// <summary>
        /// Returns the status of a game that can be used to 
        /// - check if the game has a winner (GameOver)
        /// - get the current round number of the game
        /// - check the winners of the individual rounds
        /// </summary>
        /// <param name="id">The identifier of the game</param>
        [HttpGet("{id}/status")]
        [ProducesResponseType(typeof(GameStatus), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public IActionResult GetGameStatus(Guid id)
        {
            try
            {
                var model = _gameService.GetGameStatus(id);
                return Ok(model);
            }
            catch (DataNotFoundException)
            {
                ModelState.AddModelError("gameRoomNotFound", $"Could not find a game with id {id}");
            }
            return BadRequest(ModelState);
        }
    }
}
