using System;
using System.Threading.Tasks;
using MasterMind.Business.Models;
using MasterMind.Business.Services;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace MasterMind.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WaitingRoomsController : ControllerBase
    {
        private readonly IWaitingRoomService _waitingRoomService;
        private readonly UserManager<User> _userManager;

        public WaitingRoomsController(IWaitingRoomService waitingRoomService, UserManager<User> userManager)
        {
            _waitingRoomService = waitingRoomService;
            _userManager = userManager;
        }

        /// <summary>
        /// Returns all available waiting rooms.
        /// </summary>
        [HttpGet("")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public IActionResult GetAvailableWaitingRooms()
        {
            try
            {
                var rooms = _waitingRoomService.GetAllAvailableRooms();
                return Ok(rooms);
            }
            catch (DataNotFoundException)
            {
                return NotFound();
            }
        }

        /// <summary>
        /// Adds a new waiting room to the application
        /// </summary>
        [HttpPost("")]
        [ProducesResponseType(typeof(WaitingRoom), (int)HttpStatusCode.Created)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> StartNewWaitingRoom(WaitingRoomCreationModel roomToCreate)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var currentUser = await _userManager.GetUserAsync(User);
            try
            {
                var createdRoom = _waitingRoomService.CreateRoom(roomToCreate, currentUser);
                return CreatedAtAction(nameof(GetWaitingRoom), new {id = createdRoom.Id}, createdRoom);
            }
            catch (ApplicationException applicationException)
            {
                ModelState.AddModelError("applicationException", applicationException.Message);
                return BadRequest(ModelState);
            }
        }

        /// <summary>
        /// Returns the waiting room with a matching id.
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(WaitingRoom), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public IActionResult GetWaitingRoom(Guid id)
        {
            try
            {
                var room = _waitingRoomService.GetRoomById(id);
                return Ok(room);
            }
            catch (DataNotFoundException)
            {
                return NotFound();
            }
        }

        /// <summary>
        /// Adds the user (that sends the http request) to the room.
        /// </summary>
        [HttpPost("{id}/join")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> JoinWaitingRoom(Guid id)
        {
            var currentUser = await _userManager.GetUserAsync(User);

            if(!_waitingRoomService.TryJoinRoom(id, currentUser, out string failureReason))
            {
                ModelState.AddModelError("joinrefused", failureReason);
                return BadRequest(ModelState);
            }

            return Ok();
        }

        /// <summary>
        /// Removes the user (that sends the http request) from the room
        /// </summary>
        [HttpPost("{id}/leave")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> LeaveWaitingRoom(Guid id)
        {
            var currentUser = await _userManager.GetUserAsync(User);

            if (!_waitingRoomService.TryLeaveRoom(id, currentUser, out string failureReason))
            {
                ModelState.AddModelError("leavefailed", failureReason);
                return BadRequest(ModelState);
            }

            return Ok();
        }
    }
}