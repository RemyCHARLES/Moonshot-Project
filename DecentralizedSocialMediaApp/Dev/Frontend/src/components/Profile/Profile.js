import React from 'react';
import PropTypes from 'prop-types';
import './Profile.css';

const Profile = ({ username, bio, profilePic }) => (
  <div className="profile">
    <img src={profilePic} alt={`${username}'s profile`} className="profile-pic" />
    <h1 className="profile-username">{username}</h1>
    <p className="profile-bio">{bio}</p>
    {/* You can add other elements, like a list of user posts, friends, etc. */}
  </div>
);

Profile.propTypes = {
  username: PropTypes.string.isRequired,
  bio: PropTypes.string,
  profilePic: PropTypes.string,
};

export default Profile;
