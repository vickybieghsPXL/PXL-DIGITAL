using System;
using MasterMind.Business.Models;
using MasterMind.Data.DomainClasses;
using MasterMind.Data.Repositories;
using System.Collections.Generic;
using System.Linq;
using MasterMind.Data;

namespace MasterMind.Business.Services
{
    public class WaitingRoomService : IWaitingRoomService
    {
        private IWaitingRoomRepository WaitingRoomRepository;

        public WaitingRoomService(IWaitingRoomRepository waitingRoomRepository)
        {
            WaitingRoomRepository = waitingRoomRepository;
        }

        private bool ContainsUser(User user, WaitingRoom room)
        {
            foreach (User u in room.Users)
            {
                if (u.Id == user.Id)
                {
                    return true;
                }
            }

            return false;
        }

        private bool RemoveUser(User user, WaitingRoom room)
        {
            foreach (User u in room.Users)
            {
                if (u.Id == user.Id)
                {
                    room.Users.Remove(u);
                    return true;
                }
            }
            return false;
        }

        private bool IsRoomFull(WaitingRoom room)
        {
            if (room.Users.Count >= room.MaximumAmountOfUsers)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool DoesRoomExist(WaitingRoom room)
        {
            if (room != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool IsUserAlreadyInRoom(WaitingRoom room, User user)
        {
            return (ContainsUser(user, room));
        }

        private bool HasRoomUniqueName(WaitingRoom room)
        {
            foreach (WaitingRoom w in WaitingRoomRepository.GetAll())
            {
                if (w.Name == room.Name)
                {
                    return false;
                }
            }
            
            return true;
        }

        private bool IsUserCreator(WaitingRoom room, User user)
        {
            return (room.CreatorUserId == user.Id);

        }

        public ICollection<WaitingRoom> GetAllAvailableRooms()
        {
            ICollection<WaitingRoom> rooms = new List<WaitingRoom>();

            foreach (WaitingRoom w in WaitingRoomRepository.GetAll())
            {
                if (!(IsRoomFull(w) && DoesRoomExist(w)))
                {
                    rooms.Add(w);
                }
            }

            return rooms;
        }

        public WaitingRoom CreateRoom(WaitingRoomCreationModel roomToCreate, User creator)
        {
            WaitingRoom room = new WaitingRoom(roomToCreate.Name, creator, roomToCreate.GameSettings);

            if (HasRoomUniqueName(room))
            {
                WaitingRoomRepository.Add(room);
                return room;
            }
            else
            {
                throw new ApplicationException();
            }

            
        }

        public WaitingRoom GetRoomById(Guid id)
        {
            WaitingRoom room;

            try
            {
                room = WaitingRoomRepository.GetById(id);
            }
            catch (DataNotFoundException)
            {
                return null;
            }

            return room;
            
        }

        public bool TryJoinRoom(Guid roomId, User user, out string failureReason)
        {
            WaitingRoom room = GetRoomById(roomId);

            if (DoesRoomExist(room))
            {
                if (IsUserAlreadyInRoom(room, user))
                {
                    failureReason = "User is already in room.";
                    return false;
                }
                else
                {
                    if (IsRoomFull(room))
                    {
                        failureReason = "Room is full.";
                        return false;
                    }
                    else
                    {
                        failureReason = "";
                        room.Users.Add(user);
                        return true;
                    }
                }
            }
            else
            {
                failureReason = "Room doesn't exist.";
                return false;
            }

        }

        public bool TryLeaveRoom(Guid roomId, User user, out string failureReason)
        {
            WaitingRoom room = GetRoomById(roomId);

            if (DoesRoomExist(room))
            {
                if (IsUserAlreadyInRoom(room, user))
                {
                    if (IsUserCreator(room, user))
                    {
                        WaitingRoomRepository.DeleteById(roomId);
                    }
                    else
                    {
                        RemoveUser(user, room);
                    }

                    failureReason = "";
                    return true;
                }
                else
                {
                    failureReason = "User not in room.";
                    return false;
                }
            }
            else
            {
                failureReason = "Room doesn't exist.";
                return false;
            }
        }
    }
}