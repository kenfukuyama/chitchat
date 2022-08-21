

# For class models

#### - For PublicChannels(rooms)

* `publicChannel.name`: unique channel name associated with each channel(room)
* `publicChannel.nickname`: non-unique channel name associated with each channel(room)

#### - For Users

* `User.username`: unique string associated with each user
* `User.nickname`: non-unique string associated with each user


#### - For Friendship

* <mark>They are bidirectional</mark>, meaning that (user_id, friend_id) also represents (friend_id, user_id), and only one of them should exists in the database
(e.g. (user_id, friend_id) = (1, 2) is the same as (2, 1), and both only one should exist in the database).



# For session vars

* `roomSelection`: unique channel name (publicChannel.name - see above) that the loggedin user is currently in.
* `id`: loggedin user.id
* `username`: loggedin user.username
* `nickname`: loggedin user.nickname
