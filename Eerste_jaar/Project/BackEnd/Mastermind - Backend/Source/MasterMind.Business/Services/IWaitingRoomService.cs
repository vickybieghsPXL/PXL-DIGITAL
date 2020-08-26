using System;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using MasterMind.Business.Models;
using System.Collections.Generic;

namespace MasterMind.Business.Services
{
    public interface IWaitingRoomService
    {
        /// <summary>
        ///  Retreives all waiting rooms that are not full
        /// </summary>
        ICollection<WaitingRoom> GetAllAvailableRooms();

        /// <summary>
        /// Creates a waiting room and registers the room in the system
        /// </summary>
        /// <param name="roomToCreate">Object containting information to creat a new room</param>
        /// <param name="creator">The user that is creating the room and that should be added as the first player in the room</param>
        /// <returns>
        /// A waiting room instance with a positive id
        /// </returns>
        WaitingRoom CreateRoom(WaitingRoomCreationModel roomToCreate, User creator);

        /// <summary>
        /// Retrieves an existing waiting room by id
        /// </summary>
        /// <param name="id">Identifier of the waiting room</param>
        /// <exception cref="DataNotFoundException">When no room with identifier <paramref name="id"/> can be found</exception>
        WaitingRoom GetRoomById(Guid id);

        /// <summary>
        /// Tries to link a user to a room
        /// </summary>
        /// <param name="roomId">The identifier of the room</param>
        /// <param name="user">The user that wants to join</param>
        /// <param name="failureReason">
        /// Will contain the reason when it is not possible to join the room.
        /// <example>The room could not be found or the room could already be full</example>
        /// </param>
        /// <returns>An indication if the operation succeeded</returns>
        bool TryJoinRoom(Guid roomId, User user, out string failureReason);

        /// <summary>
        /// Tries to remove a user from a room
        /// </summary>
        /// <param name="roomId">The identifier of the room</param>
        /// <param name="user">The user that should be removed</param>
        /// <param name="failureReason">
        /// Will contain the reason when it is not possible to leave the room.
        /// <example>The room could not be found or the user is not linked to the room</example>
        /// </param>
        /// <returns>An indication if the operation succeeded</returns>
        bool TryLeaveRoom(Guid roomId, User user, out string failureReason);
    }
}
